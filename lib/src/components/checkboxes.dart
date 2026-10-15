import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_assistive_ui_components/src/components/base/interactive_state_mixin.dart';
import 'package:flutter_assistive_ui_components/src/helpers/preset_size_multiplier.dart';
import 'package:flutter_assistive_ui_components/src/providers/providers.dart';

/// Custom Checkbox Component
///
/// Um checkbox altamente customizável que suporta:
/// - Gerenciamento de estado interno (checked)
/// - Callback de estado externo (onChanged)
/// - Configuração global via UserComponentProvider
/// - Feedback háptico opcional
/// - Mensagens de feedback visual opcional
/// - Renderização visual escalável

class AssistiveUICheckbox extends StatefulWidget {
  final bool initialChecked;
  final ValueChanged<bool>? onChanged;
  final double scale;
  final double touchPadding;
  final double padding;
  final Duration pressDelay;
  final bool enableHaptic;
  final Color color;
  final Duration hapticDuration;
  final bool showFeedback;
  final String feedbackTextOnCheck;
  final String feedbackTextOnUncheck;

  const AssistiveUICheckbox({
    super.key,
    required this.onChanged,
    this.initialChecked = false,
    this.scale = 1.4,
    this.touchPadding = 16,
    this.color = Colors.blue,
    this.padding = 8,
    this.enableHaptic = false,
    this.pressDelay = Duration.zero,
    this.hapticDuration = const Duration(milliseconds: 30),
    this.showFeedback = false,
    this.feedbackTextOnCheck = "Marcado",
    this.feedbackTextOnUncheck = "Desmarcado",
  });

  @override
  State<AssistiveUICheckbox> createState() => _AssistiveUICheckboxState();
}

class _AssistiveUICheckboxState extends State<AssistiveUICheckbox>
    with InteractiveStateMixin<AssistiveUICheckbox> {
  late bool _checked;

  static const prefix = "checkbox";

  @override
  void initState() {
    super.initState();
    _checked = widget.initialChecked;
  }

  Future<void> _handleToggle(
    BuildContext context,
    bool enableHaptic,
    bool showFeedback,
    Duration pressDelay,
  ) async {
    if (isLocked) return;

    await handleInteraction(
      onAction: () {
        setState(() => _checked = !_checked);
        widget.onChanged?.call(_checked);
      },
      enableHaptic: enableHaptic,
      showFeedback: showFeedback,
      pressDelay: pressDelay,
      hapticDuration: widget.hapticDuration,
      feedbackText: _checked ? widget.feedbackTextOnCheck : widget.feedbackTextOnUncheck,
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<UserComponentProvider>();

    final scale = provider.getConfig<double>("${prefix}_scale") ?? widget.scale;
    final padding = getScaledPresetConfig(provider, prefix, 'padding', widget.padding);
    final touchPadding = getScaledPresetConfig(provider, prefix, 'touchPadding', widget.touchPadding);
    final color = provider.getConfig<Color>("${prefix}_color") ?? widget.color;
    final enableHaptic = provider.getConfig<bool>("${prefix}_enableHaptic") ?? widget.enableHaptic;
    final showFeedback = provider.getConfig<bool>("${prefix}_showFeedback") ?? widget.showFeedback;
    final pressDelayMs =
        provider.getConfig<num>("${prefix}_pressDelay")?.toInt() ?? widget.pressDelay.inMilliseconds;
    final pressDelay = Duration(milliseconds: pressDelayMs);

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () => _handleToggle(context, enableHaptic, showFeedback, pressDelay),
      child: Padding(
        padding: EdgeInsets.all(touchPadding),
        child: Container(
          padding: EdgeInsets.all(padding),
          decoration: const BoxDecoration(color: Colors.transparent),
          child: SizedBox(
            child: Transform.scale(
              scale: scale,
              child: Checkbox(
                value: _checked,
                onChanged:
                    isLocked
                        ? null
                        : (_) => _handleToggle(context, enableHaptic, showFeedback, pressDelay),
                fillColor: WidgetStateProperty.resolveWith<Color>((states) {
                  if (states.contains(WidgetState.selected)) {
                    return color;
                  }
                  return Colors.transparent;
                }),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
