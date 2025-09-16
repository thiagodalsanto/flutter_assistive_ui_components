// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:flutter_assistive_ui_components/src/internal/floating_feedback.dart';
import 'package:flutter_assistive_ui_components/src/providers/providers.dart';

class AssistiveUIAlertDialog extends StatefulWidget {
  final String title;
  final String content;
  final String confirmText;
  final String cancelText;
  final String? feedbackText;
  final Color titleColor;
  final Color contentColor;
  final Color backgroundColor;
  final FontStyle titleStyle;
  final FontStyle contentStyle;
  final VoidCallback? onConfirm;
  final VoidCallback? onCancel;
  final bool enableHaptic;
  final bool showFeedback;
  final double width;
  final double padding;
  final double borderRadius;
  final Duration pressDelay;
  final double confirmWidth;
  final double confirmHeight;
  final double confirmBorderRadius;
  final Color confirmBackgroundColor;
  final Color confirmTextColor;
  final double cancelWidth;
  final double cancelHeight;
  final double cancelBorderRadius;
  final Color cancelBackgroundColor;
  final Color cancelTextColor;

  const AssistiveUIAlertDialog({
    super.key,
    this.title = "Title",
    this.content = "Content",
    this.confirmText = "OK",
    this.cancelText = "Cancel",
    this.feedbackText,
    this.onConfirm,
    this.onCancel,
    this.width = 300,
    this.padding = 16,
    this.borderRadius = 16,
    this.pressDelay = Duration.zero,
    this.showFeedback = true,
    this.enableHaptic = true,
    this.backgroundColor = Colors.white,
    this.titleColor = Colors.black,
    this.contentColor = Colors.black87,
    this.titleStyle = FontStyle.normal,
    this.contentStyle = FontStyle.normal,
    this.confirmWidth = 110,
    this.confirmHeight = 40,
    this.confirmBorderRadius = 8,
    this.confirmBackgroundColor = Colors.blue,
    this.confirmTextColor = Colors.white,
    this.cancelWidth = 110,
    this.cancelHeight = 40,
    this.cancelBorderRadius = 8,
    this.cancelBackgroundColor = Colors.grey,
    this.cancelTextColor = Colors.white,
  });

  @override
  State<AssistiveUIAlertDialog> createState() => _AssistiveUIAlertDialogState();
}

class _AssistiveUIAlertDialogState extends State<AssistiveUIAlertDialog> {
  static const String prefix = "alertdialog";

  late double width;
  late double padding;
  late double borderRadius;
  late Color backgroundColor;
  late Color titleColor;
  late Color contentColor;
  late bool enableHaptic;
  late bool showFeedback;
  late String? feedbackText;
  late Duration pressDelay;
  late double confirmWidth;
  late double confirmHeight;
  late double confirmBorderRadius;
  late Color confirmBackgroundColor;
  late Color confirmTextColor;
  late double cancelWidth;
  late double cancelHeight;
  late double cancelBorderRadius;
  late Color cancelBackgroundColor;
  late Color cancelTextColor;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final provider = context.watch<UserComponentProvider>();

    width = provider.getConfig<double>("${prefix}_width") ?? widget.width;
    padding = provider.getConfig<double>("${prefix}_padding") ?? widget.padding;
    borderRadius = provider.getConfig<double>("${prefix}_borderRadius") ?? widget.borderRadius;
    backgroundColor = provider.getConfig<Color>("${prefix}_backgroundColor") ?? widget.backgroundColor;
    titleColor = provider.getConfig<Color>("${prefix}_titleColor") ?? widget.titleColor;
    contentColor = provider.getConfig<Color>("${prefix}_contentColor") ?? widget.contentColor;
    enableHaptic = provider.getConfig<bool>("${prefix}_enableHaptic") ?? widget.enableHaptic;
    showFeedback = provider.getConfig<bool>("${prefix}_showFeedback") ?? widget.showFeedback;
    confirmWidth = provider.getConfig<double>("${prefix}_confirmWidth") ?? widget.confirmWidth;
    confirmHeight = provider.getConfig<double>("${prefix}_confirmHeight") ?? widget.confirmHeight;
    confirmBorderRadius =
        provider.getConfig<double>("${prefix}_confirmRadius") ?? widget.confirmBorderRadius;
    confirmBackgroundColor =
        provider.getConfig<Color>("${prefix}_confirmBg") ?? widget.confirmBackgroundColor;
    confirmTextColor =
        provider.getConfig<Color>("${prefix}_confirmTextColor") ?? widget.confirmTextColor;
    cancelWidth = provider.getConfig<double>("${prefix}_cancelWidth") ?? widget.cancelWidth;
    cancelHeight = provider.getConfig<double>("${prefix}_cancelHeight") ?? widget.cancelHeight;
    cancelBorderRadius =
        provider.getConfig<double>("${prefix}_cancelRadius") ?? widget.cancelBorderRadius;
    cancelBackgroundColor =
        provider.getConfig<Color>("${prefix}_cancelBg") ?? widget.cancelBackgroundColor;
    cancelTextColor = provider.getConfig<Color>("${prefix}_cancelTextColor") ?? widget.cancelTextColor;
  }

  Future<void> _handleCancel() async {
    if (pressDelay > Duration.zero) {
      await Future.delayed(pressDelay);
    }

    if (enableHaptic) {
      HapticFeedback.lightImpact();
    }

    if (showFeedback) {
      showFloatingFeedback(context, feedbackText ?? "Cancelled");
    }

    if (!mounted) return;
    Navigator.pop(context);
    widget.onCancel?.call();
  }

  Future<void> _handleConfirm() async {
    if (pressDelay > Duration.zero) {
      await Future.delayed(pressDelay);
    }

    if (enableHaptic) {
      HapticFeedback.mediumImpact();
    }

    if (showFeedback) {
      showFloatingFeedback(context, feedbackText ?? "Confirmed");
    }

    if (!mounted) return;
    Navigator.pop(context);
    widget.onConfirm?.call();
  }

  Widget _buildButton({
    required String text,
    required double width,
    required double height,
    required double radius,
    required Color bgColor,
    required Color textColor,
    required VoidCallback onTap,
  }) {
    return SizedBox(
      width: width,
      height: height,
      child: Material(
        color: bgColor,
        borderRadius: BorderRadius.circular(radius),
        child: InkWell(
          borderRadius: BorderRadius.circular(radius),
          onTap: onTap,
          child: Center(
            child: Text(text, style: TextStyle(color: textColor, fontWeight: FontWeight.w500)),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: width,
        padding: EdgeInsets.all(padding),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(borderRadius),
          boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 10, offset: Offset(0, 4))],
        ),
        child: Material(
          color: Colors.transparent,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: titleColor,
                  fontStyle: widget.titleStyle,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                widget.content,
                style: TextStyle(fontSize: 14, color: contentColor, fontStyle: widget.contentStyle),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _buildButton(
                    text: widget.cancelText,
                    width: cancelWidth,
                    height: cancelHeight,
                    radius: cancelBorderRadius,
                    bgColor: cancelBackgroundColor,
                    textColor: cancelTextColor,
                    onTap: _handleCancel,
                  ),
                  const SizedBox(width: 10),
                  _buildButton(
                    text: widget.confirmText,
                    width: confirmWidth,
                    height: confirmHeight,
                    radius: confirmBorderRadius,
                    bgColor: confirmBackgroundColor,
                    textColor: confirmTextColor,
                    onTap: _handleConfirm,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
