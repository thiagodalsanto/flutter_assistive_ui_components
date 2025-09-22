import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_assistive_ui_components/src/providers/providers.dart';

/// =======================================================
/// Custom Linear Progress Indicator
///
/// Features:
/// - Dynamic styling via UserComponentProvider
/// - Supports determinate & indeterminate modes
/// - Custom height, radius, colors
/// - Optional animation smoothing
/// - Optional label display
/// =======================================================

class AssistiveUIProgressIndicator extends StatefulWidget {
  final double? value;
  final double height;
  final double width;
  final double borderRadius;
  final Color? color;
  final Color? valueColor;
  final Color borderColor;
  final bool isAnimated;
  final double? animationDuration;
  final bool showLabel;
  final Color? labelColor;

  const AssistiveUIProgressIndicator({
    super.key,
    this.value,
    this.valueColor = Colors.white,
    this.height = 8,
    this.width = 200,
    this.color = Colors.blue,
    this.borderRadius = 8,
    this.showLabel = false,
    this.isAnimated = true,
    this.animationDuration,
    this.borderColor = Colors.black,
    this.labelColor = Colors.black,
  });
  @override
  State<AssistiveUIProgressIndicator> createState() => _AssistiveUIProgressIndicatorState();
}

class _AssistiveUIProgressIndicatorState extends State<AssistiveUIProgressIndicator> {
  static const String prefix = "linearprogress";

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<UserComponentProvider>();

    final height = provider.getConfig<double>("${prefix}_height") ?? widget.height;
    final width = provider.getConfig<double>("${prefix}_width") ?? widget.width;
    final borderRadius = provider.getConfig<double>("${prefix}_borderRadius") ?? widget.borderRadius;
    final color = provider.getConfig<Color>("${prefix}_color") ?? widget.color;
    final valueColor = provider.getConfig<Color>("${prefix}_valueColor") ?? widget.valueColor;
    final showLabel = provider.getConfig<bool>("${prefix}_showLabel") ?? widget.showLabel;
    final animated = provider.getConfig<bool>("${prefix}_animated") ?? true;
    final durationMs = provider.getConfig<double>("${prefix}_animationDuration") ?? 300;
    final borderColor = provider.getConfig<Color>("${prefix}_borderColor") ?? widget.borderColor;
    final labelColor = provider.getConfig<Color>("${prefix}_labelColor") ?? widget.labelColor;

    Widget buildBar(double val) {
      return Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          border: Border.all(color: borderColor, width: 1.5),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(borderRadius),
          child: LinearProgressIndicator(
            value: val,
            backgroundColor: color,
            valueColor: AlwaysStoppedAnimation(valueColor),
          ),
        ),
      );
    }

    Widget bar;

    if (animated && widget.value != null) {
      bar = TweenAnimationBuilder<double>(
        tween: Tween(begin: 0, end: widget.value),
        duration: Duration(milliseconds: durationMs.toInt()),
        builder: (context, val, _) => buildBar(val),
      );
    } else {
      bar = buildBar(widget.value ?? 0);
    }

    if (!showLabel || widget.value == null) return bar;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        bar,
        Positioned(
          left: width + 8,
          top: (height / 2) - 8,
          child: Text(
            "${(widget.value! * 100).toInt()}%",
            style: TextStyle(color: labelColor, fontWeight: FontWeight.bold, fontSize: 18),
          ),
        ),
      ],
    );
  }
}
