// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_assistive_ui_components/src/components/base/interactive_state_mixin.dart';
import 'package:flutter_assistive_ui_components/src/providers/providers.dart';

/// Custom Switch Component
///
/// Um switch de alternância customizável com suporte para:
/// - Gerenciamento de estado interno
/// - Callback de estado externo (onChanged)
/// - Estilo global via UserComponentProvider
/// - Feedback háptico opcional
/// - Mensagens de feedback visual opcional
/// - Feedback de animação de pressão
///
/// Projetado para comportamento de alternância consistente
/// em todo o sistema de UI com suporte de configuração centralizada.

class AssistiveUISwitch extends StatefulWidget {
  final bool value;
  final ValueChanged<bool>? onChanged;

  final double width;
  final double height;
  final double touchPadding;
  final Duration pressDelay;
  final bool enableHaptic;
  final Duration hapticDuration;
  final bool showFeedback;
  final Color color;

  const AssistiveUISwitch({
    super.key,
    required this.value,
    required this.onChanged,
    this.width = 72,
    this.height = 40,
    this.touchPadding = 16,
    this.pressDelay = Duration.zero,
    this.enableHaptic = false,
    this.hapticDuration = const Duration(milliseconds: 30),
    this.showFeedback = false,
    this.color = Colors.blue,
  });

  @override
  State<AssistiveUISwitch> createState() => _AssistiveUISwitchState();
}

class _AssistiveUISwitchState extends State<AssistiveUISwitch>
    with InteractiveStateMixin<AssistiveUISwitch> {
  static const String prefix = "switch";

  late bool _currentValue;
  bool _pressed = false;

  @override
  void initState() {
    super.initState();
    _currentValue = widget.value;
  }

  Future<void> _handleToggle(
    BuildContext context,
    Duration pressDelay,
    bool enableHaptic,
    bool showFeedback,
  ) async {
    if (widget.onChanged == null) return;

    final newValue = !_currentValue;

    await handleInteraction(
      onAction: () {
        setState(() => _currentValue = newValue);
        widget.onChanged?.call(newValue);
      },
      enableHaptic: enableHaptic,
      showFeedback: showFeedback,
      pressDelay: pressDelay,
      hapticDuration: widget.hapticDuration,
      feedbackText: newValue ? "Enabled" : "Disabled",
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<UserComponentProvider>();

    final width = provider.getConfig<double>("${prefix}_width") ?? widget.width;
    final height = provider.getConfig<double>("${prefix}_height") ?? widget.height;
    final touchPadding = provider.getConfig<double>("${prefix}_touchPadding") ?? widget.touchPadding;
    final enableHaptic = provider.getConfig<bool>("${prefix}_enableHaptic") ?? widget.enableHaptic;
    final showFeedback = provider.getConfig<bool>("${prefix}_showFeedback") ?? widget.showFeedback;
    final pressDelayMs = provider.getConfig<double>("${prefix}_pressDelay") ?? 0;
    final activeColor = provider.getConfig<Color>("${prefix}_color") ?? widget.color;
    final pressDelay = Duration(milliseconds: pressDelayMs.toInt());

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: isLocked ? null : () => _handleToggle(context, pressDelay, enableHaptic, showFeedback),
      onTapDown: (_) => setState(() => _pressed = true),
      onTapUp: (_) => setState(() => _pressed = false),
      onTapCancel: () => setState(() => _pressed = false),
      child: Padding(
        padding: EdgeInsets.all(touchPadding),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24 + touchPadding),
            boxShadow:
                _pressed
                    ? [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 30,
                        offset: const Offset(0, 2),
                      ),
                    ]
                    : [],
          ),
          child: SizedBox(
            width: width,
            height: height,
            child: FittedBox(
              fit: BoxFit.contain,
              child: Switch(
                value: _currentValue,
                activeColor: activeColor,
                onChanged:
                    isLocked
                        ? null
                        : (_) => _handleToggle(context, pressDelay, enableHaptic, showFeedback),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
