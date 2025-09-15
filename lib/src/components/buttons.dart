import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_assistive_ui_components/src/components/base/interactive_state_mixin.dart';
import 'package:flutter_assistive_ui_components/src/providers/providers.dart';

/// Custom Button Component
///
/// Um botão altamente configurável que suporta:
/// - Estilo dinâmico via UserComponentProvider
/// - Feedback háptico opcional
/// - Delay de pressão configurável
/// - Overlay de feedback visual opcional
/// - Suporte a layout com ícone + texto
class AssistiveUIButton extends StatefulWidget {
  final String label;
  final IconData? icon;
  final VoidCallback? onPressed;
  final Size size;
  final double fontSize;
  final double touchPadding;
  final double padding;
  final Duration pressDelay;
  final bool enableHaptic;
  final Duration hapticDuration;
  final bool showFeedback;
  final String feedbackText;
  final Color fontColor;

  const AssistiveUIButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.fontColor = Colors.white,
    this.size = const Size(200, 56),
    this.fontSize = 16,
    this.touchPadding = 16,
    this.padding = 0,
    this.pressDelay = Duration.zero,
    this.enableHaptic = false,
    this.hapticDuration = const Duration(milliseconds: 30),
    this.showFeedback = false,
    this.feedbackText = "Button pressed",
    this.icon,
  });

  @override
  State<AssistiveUIButton> createState() => _AssistiveUIButtonState();
}

class _AssistiveUIButtonState extends State<AssistiveUIButton>
    with InteractiveStateMixin<AssistiveUIButton> {
  static const String prefix = "button";

  Future<void> _handlePress(
    BuildContext context, {
    required bool enableHaptic,
    required bool showFeedback,
    required String feedbackText,
    required Duration pressDelay,
    required Duration hapticDuration,
  }) async {
    if (widget.onPressed == null) return;

    await handleInteraction(
      onAction: widget.onPressed!,
      enableHaptic: enableHaptic,
      showFeedback: showFeedback,
      pressDelay: pressDelay,
      hapticDuration: hapticDuration,
      feedbackText: feedbackText,
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<UserComponentProvider>();

    final width = provider.getConfig<double>("${prefix}_width") ?? widget.size.width;
    final height = provider.getConfig<double>("${prefix}_height") ?? widget.size.height;
    final fontSize = provider.getConfig<double>("${prefix}_fontSize") ?? widget.fontSize;
    final touchPadding = provider.getConfig<double>("${prefix}_touchPadding") ?? widget.touchPadding;
    final padding = provider.getConfig<double>("${prefix}_padding") ?? widget.padding;
    final color = provider.getConfig<Color>("${prefix}_color") ?? Colors.blue;
    final fontColor = provider.getConfig<Color>("${prefix}_fontColor") ?? widget.fontColor;
    final enableHaptic = provider.getConfig<bool>("${prefix}_enableHaptic") ?? widget.enableHaptic;
    final showFeedback = provider.getConfig<bool>("${prefix}_showFeedback") ?? widget.showFeedback;
    final feedbackText = provider.getConfig<String>("${prefix}_feedbackText") ?? widget.feedbackText;
    final pressDelayMs = provider.getConfig<double>("${prefix}_pressDelay") ?? 0;
    final pressDelay = Duration(milliseconds: pressDelayMs.toInt());
    final iconEnabled = provider.getConfig<bool>("${prefix}_iconEnabled") ?? true;
    final icon = provider.getConfig<IconData>("${prefix}_icon") ?? widget.icon;

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap:
          isLocked
              ? null
              : () => _handlePress(
                context,
                enableHaptic: enableHaptic,
                showFeedback: showFeedback,
                feedbackText: feedbackText,
                pressDelay: pressDelay,
                hapticDuration: widget.hapticDuration,
              ),
      child: Padding(
        padding: EdgeInsets.all(touchPadding),
        child: SizedBox(
          width: width,
          height: height,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              elevation: 0,
              backgroundColor: color,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              padding: EdgeInsets.symmetric(horizontal: padding),
            ),
            onPressed:
                isLocked
                    ? null
                    : () => _handlePress(
                      context,
                      enableHaptic: enableHaptic,
                      showFeedback: showFeedback,
                      feedbackText: feedbackText,
                      pressDelay: pressDelay,
                      hapticDuration: widget.hapticDuration,
                    ),
            child: LayoutBuilder(
              builder: (context, constraints) {
                return FittedBox(
                  fit: BoxFit.scaleDown,
                  child: DefaultTextStyle(
                    style: TextStyle(fontSize: fontSize, color: fontColor),
                    child: IconTheme(
                      data: IconThemeData(color: fontColor, size: fontSize),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (icon != null && iconEnabled) ...[Icon(icon), const SizedBox(width: 6)],
                          ConstrainedBox(
                            constraints: BoxConstraints(maxWidth: constraints.maxWidth * 0.8),
                            child: Text(
                              widget.label,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              softWrap: false,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
