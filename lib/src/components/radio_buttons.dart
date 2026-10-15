// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_assistive_ui_components/src/components/base/interactive_state_mixin.dart';
import 'package:flutter_assistive_ui_components/src/helpers/preset_size_multiplier.dart';
import 'package:flutter_assistive_ui_components/src/providers/providers.dart';

/// =======================================================
/// Custom Radio Button Component
///
/// A generic radio button implementation with support for:
/// - Generic type selection (T)
/// - Group-based selection control
/// - Global configuration via UserComponentProvider
/// - Optional haptic feedback
/// - Optional floating feedback messages
/// - Press delay handling
///
/// Designed for scalable UI systems where radio behavior
/// and styling can be centrally managed.
/// =======================================================

class AssistiveUIRadio<T> extends StatefulWidget {
  final T value;
  final T groupValue;
  final ValueChanged<T>? onChanged;
  final double size;
  final Color color;
  final double touchPadding;
  final double padding;
  final Duration pressDelay;
  final bool enableHaptic;
  final Duration hapticDuration;
  final bool showFeedback;

  const AssistiveUIRadio({
    super.key,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    this.size = 16,
    this.color = Colors.blue,
    this.touchPadding = 8,
    this.padding = 0,
    this.pressDelay = Duration.zero,
    this.enableHaptic = false,
    this.hapticDuration = const Duration(milliseconds: 30),
    this.showFeedback = false,
  });

  @override
  State<AssistiveUIRadio<T>> createState() => _AssistiveUIRadioState<T>();
}

class _AssistiveUIRadioState<T> extends State<AssistiveUIRadio<T>>
    with InteractiveStateMixin<AssistiveUIRadio<T>> {
  static const prefix = "radio";

  Future<void> _handleTap(
    BuildContext context, {
    required bool enableHaptic,
    required bool showFeedback,
    required Duration pressDelay,
    required Duration hapticDuration,
  }) async {
    if (widget.onChanged == null) return;

    await handleInteraction(
      onAction: () => widget.onChanged!.call(widget.value),
      enableHaptic: enableHaptic,
      showFeedback: showFeedback,
      pressDelay: pressDelay,
      hapticDuration: hapticDuration,
      feedbackText: "Selecionado: ${widget.value}",
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<UserComponentProvider>();

    final size = provider.getConfig<double>("${prefix}_size") ?? widget.size;
    final touchPadding = getScaledPresetConfig(provider, prefix, 'touchPadding', widget.touchPadding);
    final padding = getScaledPresetConfig(provider, prefix, 'padding', widget.padding);
    final color = provider.getConfig<Color>("${prefix}_color") ?? widget.color;
    final enableHaptic = provider.getConfig<bool>("${prefix}_enableHaptic") ?? widget.enableHaptic;
    final showFeedback = provider.getConfig<bool>("${prefix}_showFeedback") ?? widget.showFeedback;
    final pressDelayMs =
        provider.getConfig<double>("${prefix}_pressDelay") ?? widget.pressDelay.inMilliseconds;
    final pressDelay = Duration(milliseconds: pressDelayMs.toInt());

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap:
          isLocked
              ? null
              : () => _handleTap(
                context,
                enableHaptic: enableHaptic,
                showFeedback: showFeedback,
                pressDelay: pressDelay,
                hapticDuration: widget.hapticDuration,
              ),
      child: Padding(
        padding: EdgeInsets.all(touchPadding),
        child: Container(
          padding: EdgeInsets.all(padding),
          child: SizedBox(
            child: Transform.scale(
              scale: size / 8,
              child: Radio<T>(
                value: widget.value,
                groupValue: widget.groupValue,
                onChanged:
                    isLocked
                        ? null
                        : (_) => _handleTap(
                          context,
                          enableHaptic: enableHaptic,
                          showFeedback: showFeedback,
                          pressDelay: pressDelay,
                          hapticDuration: widget.hapticDuration,
                        ),
                activeColor: color,
                fillColor: WidgetStateProperty.resolveWith((states) {
                  if (states.contains(WidgetState.selected)) {
                    return color;
                  }
                  return Colors.grey.withOpacity(0.6);
                }),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
