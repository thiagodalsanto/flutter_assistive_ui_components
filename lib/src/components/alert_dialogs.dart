// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:flutter_assistive_ui_components/src/helpers/preset_size_multiplier.dart';
import 'package:flutter_assistive_ui_components/src/internal/floating_feedback.dart';
import 'package:flutter_assistive_ui_components/src/providers/providers.dart';

class AssistiveUIAlertDialog extends StatefulWidget {
  final String title;
  final String content;
  final String confirmText;
  final String cancelText;
  final String? feedbackText;
  final Widget? contentWidget;
  final List<Widget>? actions;
  final WrapAlignment actionsAlignment;
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
    this.title = "Título",
    this.content = "Conteúdo",
    this.confirmText = "Confirmar",
    this.cancelText = "Cancelar",
    this.feedbackText,
    this.contentWidget,
    this.actions,
    this.actionsAlignment = WrapAlignment.end,
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
  String? feedbackText;
  Duration pressDelay = Duration.zero;
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

    width = getScaledPresetConfig(provider, prefix, 'width', widget.width)
        .clamp(0.0, MediaQuery.sizeOf(context).width - 32);
    padding = getScaledPresetConfig(provider, prefix, 'padding', widget.padding);
    borderRadius = provider.getConfig<double>("${prefix}_borderRadius") ?? widget.borderRadius;
    backgroundColor = provider.getConfig<Color>("${prefix}_backgroundColor") ?? widget.backgroundColor;
    titleColor = provider.getConfig<Color>("${prefix}_titleColor") ?? widget.titleColor;
    contentColor = provider.getConfig<Color>("${prefix}_contentColor") ?? widget.contentColor;
    enableHaptic = provider.getConfig<bool>("${prefix}_enableHaptic") ?? widget.enableHaptic;
    showFeedback = provider.getConfig<bool>("${prefix}_showFeedback") ?? widget.showFeedback;
    feedbackText = provider.getConfig<String>("${prefix}_feedbackText") ?? widget.feedbackText;
    final pressDelayMs =
        provider.getConfig<num>("${prefix}_pressDelay")?.toInt() ?? widget.pressDelay.inMilliseconds;
    pressDelay = Duration(milliseconds: pressDelayMs);
    confirmWidth = getScaledPresetConfig(provider, prefix, 'confirmWidth', widget.confirmWidth);
    confirmHeight = getScaledPresetConfig(provider, prefix, 'confirmHeight', widget.confirmHeight);
    confirmBorderRadius =
        provider.getConfig<double>("${prefix}_confirmRadius") ?? widget.confirmBorderRadius;
    confirmBackgroundColor =
        provider.getConfig<Color>("${prefix}_confirmBg") ?? widget.confirmBackgroundColor;
    confirmTextColor =
        provider.getConfig<Color>("${prefix}_confirmTextColor") ?? widget.confirmTextColor;
    cancelWidth = getScaledPresetConfig(provider, prefix, 'cancelWidth', widget.cancelWidth);
    cancelHeight = getScaledPresetConfig(provider, prefix, 'cancelHeight', widget.cancelHeight);
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
      showFloatingFeedback(context, feedbackText ?? "Cancelado");
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
      showFloatingFeedback(context, feedbackText ?? "Confirmado");
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
    final theme = Theme.of(context);

    return Dialog(
      backgroundColor: backgroundColor,
      insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(borderRadius)),
      elevation: 12,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: width),
        child: SizedBox(
          width: width,
          child: Padding(
            padding: EdgeInsets.all(padding),
            child: Material(
              color: Colors.transparent,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                Text(
                  widget.title,
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: titleColor,
                    fontStyle: widget.titleStyle,
                  ),
                ),
                const SizedBox(height: 20),
                if (widget.contentWidget case final content?)
                  ConstrainedBox(
                    constraints: BoxConstraints(
                      maxHeight: MediaQuery.sizeOf(context).height * 0.6,
                    ),
                    child: SingleChildScrollView(child: content),
                  )
                else
                  Text(
                    widget.content,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: contentColor,
                      fontStyle: widget.contentStyle,
                    ),
                  ),
                const SizedBox(height: 20),
                Divider(height: 1, color: theme.colorScheme.outlineVariant),
                const SizedBox(height: 12),
                if (widget.actions case final actions?)
                  Wrap(
                    alignment: widget.actionsAlignment,
                    spacing: 8,
                    runSpacing: 4,
                    children: actions,
                  )
                else
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
        ),
      ),
    );
  }
}
