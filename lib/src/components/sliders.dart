// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'package:flutter_assistive_ui_components/src/helpers/preset_size_multiplier.dart';
import 'package:flutter_assistive_ui_components/src/internal/floating_feedback.dart';
import 'package:flutter_assistive_ui_components/src/providers/providers.dart';

class AssistiveUISlider extends StatefulWidget {
  final double value;
  final ValueChanged<double> onChanged;
  final double width;
  final double height;
  final double padding;
  final double touchPadding;
  final bool enableHaptic;
  final Duration hapticDuration;
  final bool showFeedback;
  final double min;
  final double max;
  final double divisions;
  final Color inactiveColor;
  final Color activeColor;
  final Duration pressDelay;

  const AssistiveUISlider({
    super.key,
    required this.value,
    required this.onChanged,
    this.width = 300,
    this.height = 8,
    this.padding = 16,
    this.touchPadding = 8,
    this.enableHaptic = false,
    this.hapticDuration = const Duration(milliseconds: 30),
    this.showFeedback = false,
    this.min = 0.0,
    this.max = 1.0,
    this.divisions = 100,
    this.pressDelay = Duration.zero,
    this.activeColor = Colors.blue,
    this.inactiveColor = Colors.grey,
  });

  @override
  State<AssistiveUISlider> createState() => _AssistiveUISliderState();
}

class _AssistiveUISliderState extends State<AssistiveUISlider> {
  static const prefix = "slider";
  late double _value;

  @override
  void initState() {
    super.initState();
    _value = widget.value;
  }

  Future<void> _handleChange(
    double v, {
    required bool enableHaptic,
    required bool showFeedback,
    required Duration pressDelay,
    required Duration hapticDuration,
  }) async {
    if (pressDelay > Duration.zero) {
      await Future.delayed(pressDelay);
    }

    setState(() => _value = v);
    widget.onChanged(v);

    if (enableHaptic) {
      HapticFeedback.selectionClick();
      await Future.delayed(hapticDuration);
    }

    if (showFeedback) {
      showFloatingFeedback(context, "Valor: ${v.toStringAsFixed(2)}");
    }
  }

  void _updateFromDx(double dx, double width) {
    final clamped = dx.clamp(0.0, width);
    final percent = clamped / width;

    final value = widget.min + (widget.max - widget.min) * percent;

    _handleChange(
      value,
      enableHaptic: true,
      showFeedback: widget.showFeedback,
      pressDelay: Duration.zero,
      hapticDuration: widget.hapticDuration,
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<UserComponentProvider>();

    final width = getScaledPresetConfig(provider, prefix, 'width', widget.width);
    final height = getScaledPresetConfig(provider, prefix, 'height', widget.height);
    final padding = getScaledPresetConfig(provider, prefix, 'padding', widget.padding);
    final touchPadding = getScaledPresetConfig(provider, prefix, 'touchPadding', widget.touchPadding);
    final activeColor = provider.getConfig<Color>("${prefix}_activeColor") ?? widget.activeColor;
    final inactiveColor = provider.getConfig<Color>("${prefix}_inactiveColor") ?? widget.inactiveColor;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onPanDown: (d) => _updateFromDx(d.localPosition.dx, width),
      onPanUpdate: (d) => _updateFromDx(d.localPosition.dx, width),
      onTapDown: (d) => _updateFromDx(d.localPosition.dx, width),
      child: Padding(
        padding: EdgeInsets.all(touchPadding),
        child: Container(
          padding: EdgeInsets.all(padding),
          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.centerLeft,
            children: [
              Container(
                height: height,
                width: width,
                decoration: BoxDecoration(
                  color: inactiveColor,
                  borderRadius: BorderRadius.circular(height / 2),
                ),
              ),
              FractionallySizedBox(
                widthFactor: (_value - widget.min) / (widget.max - widget.min),
                child: Container(
                  height: height,
                  decoration: BoxDecoration(
                    color: activeColor,
                    borderRadius: BorderRadius.circular(height / 2),
                  ),
                ),
              ),
              Align(
                alignment: Alignment(-1 + 2 * ((_value - widget.min) / (widget.max - widget.min)), 0),
                child: Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    color: activeColor,
                    shape: BoxShape.circle,
                    border: Border.all(color: activeColor, width: 2),
                    boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 4, spreadRadius: 1)],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
