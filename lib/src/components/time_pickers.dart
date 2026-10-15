// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'package:flutter_assistive_ui_components/src/helpers/preset_size_multiplier.dart';
import 'package:flutter_assistive_ui_components/src/internal/floating_feedback.dart';
import 'package:flutter_assistive_ui_components/src/providers/providers.dart';

/// =======================================================
/// Custom Time Picker Component
///
/// Features:
/// - Opens native showTimePicker dialog
/// - Global styling via UserComponentProvider
/// - Optional haptic feedback
/// - Optional floating feedback
/// - Delay before opening picker
/// =======================================================

class AssistiveUITimePicker extends StatefulWidget {
  final TimeOfDay? value;
  final ValueChanged<TimeOfDay>? onChanged;

  final double width;
  final double height;
  final double touchPadding;
  final double padding;
  final double fontSize;
  final Duration pressDelay;
  final bool enableHaptic;
  final Duration hapticDuration;
  final bool showFeedback;
  final Color color;
  final Color fontColor;
  final String label;

  const AssistiveUITimePicker({
    super.key,
    this.value,
    this.onChanged,
    this.label = "Selecionar horário",
    this.width = 200,
    this.height = 56,
    this.fontSize = 16,
    this.touchPadding = 8,
    this.padding = 0,
    this.pressDelay = Duration.zero,
    this.enableHaptic = false,
    this.hapticDuration = const Duration(milliseconds: 30),
    this.showFeedback = false,
    this.color = Colors.white,
    this.fontColor = Colors.black,
  });

  @override
  State<AssistiveUITimePicker> createState() => _AssistiveUITimePickerState();
}

class _AssistiveUITimePickerState extends State<AssistiveUITimePicker> {
  late TimeOfDay? _currentValue;

  static const String prefix = "timepicker";

  @override
  void initState() {
    super.initState();
    _currentValue = widget.value;
  }

  Future<void> _handleOpen(
    BuildContext context,
    bool enableHaptic,
    bool showFeedback,
    Duration pressDelay,
  ) async {
    if (pressDelay > Duration.zero) {
      await Future.delayed(pressDelay);
    }

    if (enableHaptic) {
      HapticFeedback.mediumImpact();
      await Future.delayed(widget.hapticDuration);
    }

    final picked = await showTimePicker(context: context, initialTime: _currentValue ?? TimeOfDay.now());

    if (picked != null) {
      setState(() => _currentValue = picked);
      widget.onChanged?.call(picked);

      if (showFeedback) {
        showFloatingFeedback(context, "Horário selecionado: ${picked.format(context)}");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<UserComponentProvider>();

    final width = getScaledPresetConfig(provider, prefix, 'width', widget.width);
    final height = getScaledPresetConfig(provider, prefix, 'height', widget.height);
    final touchPadding = getScaledPresetConfig(provider, prefix, 'touchPadding', widget.touchPadding);
    final fontSize = getScaledPresetConfig(provider, prefix, 'fontSize', widget.fontSize);
    final padding = getScaledPresetConfig(provider, prefix, 'padding', widget.padding);
    final color = provider.getConfig<Color>("${prefix}_color") ?? widget.color;
    final fontColor = provider.getConfig<Color>("${prefix}_fontColor") ?? widget.fontColor;
    final enableHaptic = provider.getConfig<bool>("${prefix}_enableHaptic") ?? widget.enableHaptic;
    final showFeedback = provider.getConfig<bool>("${prefix}_showFeedback") ?? widget.showFeedback;
    final pressDelayMs =
        provider.getConfig<double>("${prefix}_pressDelay") ?? widget.pressDelay.inMilliseconds;
    final pressDelay = Duration(milliseconds: pressDelayMs.toInt());

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () => _handleOpen(context, enableHaptic, showFeedback, pressDelay),
      child: Padding(
        padding: EdgeInsets.all(touchPadding),
        child: Container(
          width: width,
          height: height,
          padding: EdgeInsets.symmetric(horizontal: padding),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.black12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _currentValue == null ? widget.label : _currentValue!.format(context),
                style: TextStyle(color: fontColor, fontSize: fontSize),
              ),
              Icon(Icons.access_time, color: fontColor, size: fontSize * 1.5),
            ],
          ),
        ),
      ),
    );
  }
}
