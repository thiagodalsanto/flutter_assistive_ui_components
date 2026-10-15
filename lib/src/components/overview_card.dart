import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_assistive_ui_components/src/components/base/interactive_state_mixin.dart';
import 'package:flutter_assistive_ui_components/src/helpers/preset_size_multiplier.dart';
import 'package:flutter_assistive_ui_components/src/providers/providers.dart';

class AssistiveUIOverviewCard extends StatefulWidget {
  final int value;
  final String title;
  final String? subtitle;
  final Color? color;
  final Color? surfaceTintColor;
  final VoidCallback? onPressed;
  final Duration pressDelay;
  final bool enableHaptic;
  final Duration hapticDuration;
  final bool showFeedback;
  final String feedbackText;
  final double height;
  final double touchPadding;

  const AssistiveUIOverviewCard({
    super.key,
    required this.value,
    required this.title,
    this.subtitle,
    this.color,
    this.surfaceTintColor,
    this.onPressed,
    this.pressDelay = const Duration(milliseconds: 100),
    this.enableHaptic = true,
    this.hapticDuration = const Duration(milliseconds: 50),
    this.showFeedback = true,
    this.feedbackText = "Cartão pressionado",
    this.height = 100.0,
    this.touchPadding = 4.0,
  });

  @override
  State<AssistiveUIOverviewCard> createState() => _AssistiveUIOverviewCardState();
}

class _AssistiveUIOverviewCardState extends State<AssistiveUIOverviewCard>
    with InteractiveStateMixin<AssistiveUIOverviewCard> {
  static const String prefix = "overviewcard";
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

    final height = getScaledPresetConfig(provider, prefix, 'height', widget.height);
    final touchPadding = getScaledPresetConfig(provider, prefix, 'touchPadding', widget.touchPadding);
    final sizeMultiplier = getPresetSizeMultiplier(provider, prefix);
    final textTheme = Theme.of(context).textTheme;
    final color = provider.getConfig<Color>("${prefix}_color") ?? widget.color;
    final surfaceTintColor =
        provider.getConfig<Color>("${prefix}_surfaceTintColor") ?? widget.surfaceTintColor;
    final enableHaptic = provider.getConfig<bool>("${prefix}_enableHaptic") ?? widget.enableHaptic;
    final showFeedback = provider.getConfig<bool>("${prefix}_showFeedback") ?? widget.showFeedback;
    final feedbackText = provider.getConfig<String>("${prefix}_feedbackText") ?? widget.feedbackText;
    final pressDelayMs = provider.getConfig<double>("${prefix}_pressDelay") ?? 0;
    final pressDelay = Duration(milliseconds: pressDelayMs.toInt());

    return Padding(
      padding: EdgeInsets.all(touchPadding),
      child: SizedBox(
        height: height,
        child: Card(
          color: color,
          surfaceTintColor: surfaceTintColor,
          child: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap:
                () => _handlePress(
                  context,
                  enableHaptic: enableHaptic,
                  showFeedback: showFeedback,
                  feedbackText: feedbackText,
                  pressDelay: pressDelay,
                  hapticDuration: widget.hapticDuration,
                ),
            child: Padding(
              padding: EdgeInsets.all(16 * sizeMultiplier),
              child: Row(
                children: [
                  Text(
                    widget.value.toString(),
                    style: textTheme.displayMedium?.copyWith(
                      color: surfaceTintColor,
                      fontSize: (textTheme.displayMedium?.fontSize ?? 0) * sizeMultiplier,
                    ),
                  ),
                  SizedBox(width: 16 * sizeMultiplier),
                  Expanded(
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      alignment: Alignment.centerLeft,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.title,
                            style: textTheme.titleLarge?.copyWith(
                              color: surfaceTintColor,
                              fontSize: (textTheme.titleLarge?.fontSize ?? 0) * sizeMultiplier,
                            ),
                          ),
                          if (widget.subtitle != null) ...[
                            SizedBox(height: 8 * sizeMultiplier),
                            Text(
                              widget.subtitle!,
                              style: textTheme.bodyLarge?.copyWith(
                                color: surfaceTintColor,
                                fontSize: (textTheme.bodyLarge?.fontSize ?? 0) * sizeMultiplier,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
