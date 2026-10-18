import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_assistive_ui_components/src/components/base/interactive_state_mixin.dart';
import 'package:flutter_assistive_ui_components/src/helpers/preset_size_multiplier.dart';
import 'package:flutter_assistive_ui_components/src/providers/providers.dart';

/// Custom Button Component
///
/// Um botão altamente configurável que suporta:
/// - Estilo dinâmico via UserComponentProvider
/// - Feedback háptico opcional
/// - Delay de pressão configurável
/// - Overlay de feedback visual opcional
/// - Suporte a layout com ícone + texto
class AssistiveUIBigButton extends StatefulWidget {
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
  final Color color;
  final bool swapIconLabel;
  final bool iconEnabled;
  final int elevation;

  const AssistiveUIBigButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.fontColor = Colors.white,
    this.color = Colors.blue,
    this.size = const Size(double.infinity, 80),
    this.fontSize = 16,
    this.touchPadding = 16,
    this.padding = 0,
    this.pressDelay = Duration.zero,
    this.enableHaptic = false,
    this.hapticDuration = const Duration(milliseconds: 30),
    this.showFeedback = false,
    this.feedbackText = "Botão pressionado",
    this.swapIconLabel = false,
    this.iconEnabled = true,
    this.elevation = 0,
    this.icon,
  });

  @override
  State<AssistiveUIBigButton> createState() => _AssistiveUIBigButtonState();
}

class _AssistiveUIBigButtonState extends State<AssistiveUIBigButton>
    with InteractiveStateMixin<AssistiveUIBigButton> {
  static const String prefix = "bigbutton";

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

    final width = getScaledPresetConfig(
      provider,
      prefix,
      'width',
      widget.size.width,
    );
    final height = getScaledPresetConfig(
      provider,
      prefix,
      'height',
      widget.size.height,
    );
    final fontSize = getScaledPresetConfig(
      provider,
      prefix,
      'fontSize',
      widget.fontSize,
    );
    final touchPadding = getScaledPresetConfig(
      provider,
      prefix,
      'touchPadding',
      widget.touchPadding,
    );
    final padding = getScaledPresetConfig(
      provider,
      prefix,
      'padding',
      widget.padding,
    );
    final color = provider.getConfig<Color>("${prefix}_color") ?? widget.color;
    final fontColor =
        provider.getConfig<Color>("${prefix}_fontColor") ?? widget.fontColor;
    final enableHaptic =
        provider.getConfig<bool>("${prefix}_enableHaptic") ??
        widget.enableHaptic;
    final showFeedback =
        provider.getConfig<bool>("${prefix}_showFeedback") ??
        widget.showFeedback;
    final feedbackText =
        provider.getConfig<String>("${prefix}_feedbackText") ??
        widget.feedbackText;
    final pressDelayMs =
        provider.getConfig<double>("${prefix}_pressDelay") ?? 0;
    final pressDelay = Duration(milliseconds: pressDelayMs.toInt());
    final iconEnabled =
        provider.getConfig<bool>("${prefix}_iconEnabled") ?? widget.iconEnabled;
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
              elevation: widget.elevation.toDouble(),
              backgroundColor: color,
              // surfaceTint transparente: sem overlay M3 lavando a cor do preset.
              surfaceTintColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
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
                // O texto já é dimensionado pelo preset via getScaledPresetConfig.
                // O textScaler ambiente é neutralizado para evitar escala dupla
                // quando a página também aplica o textScaler do preset.
                return MediaQuery(
                  data: MediaQuery.of(
                    context,
                  ).copyWith(textScaler: TextScaler.noScaling),
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: DefaultTextStyle(
                      style: TextStyle(fontSize: fontSize, color: fontColor),
                      child: IconTheme(
                        data: IconThemeData(color: fontColor, size: fontSize),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (widget.swapIconLabel &&
                                icon != null &&
                                iconEnabled) ...[
                              ConstrainedBox(
                                constraints: BoxConstraints(
                                  maxWidth: constraints.maxWidth * 0.8,
                                ),
                                child: Text(
                                  widget.label,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  softWrap: false,
                                ),
                              ),
                              const SizedBox(width: 6),
                              Icon(icon),
                            ] else if (widget.swapIconLabel == false) ...[
                              if (icon != null && iconEnabled) ...[
                                Icon(icon),
                                const SizedBox(width: 6),
                              ],
                              ConstrainedBox(
                                constraints: BoxConstraints(
                                  maxWidth: constraints.maxWidth * 0.8,
                                ),
                                child: Text(
                                  widget.label,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  softWrap: false,
                                ),
                              ),
                            ],
                          ],
                        ),
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
