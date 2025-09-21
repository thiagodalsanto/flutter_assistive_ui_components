// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'package:flutter_assistive_ui_components/src/internal/floating_feedback.dart';
import 'package:flutter_assistive_ui_components/src/providers/providers.dart';

/// =======================================================
/// Custom Icon Button Component
///
/// A lightweight tappable icon button with support for:
/// - Configurable size and icon scaling
/// - Global styling via UserComponentProvider
/// - Optional haptic feedback
/// - Optional floating feedback messages
/// - Press delay handling
///
/// Designed for reusable UI systems where icon buttons
/// need consistent behavior across the app.
/// =======================================================

class AssistiveUIIconButton extends StatefulWidget {
  final IconData icon;
  final Color iconColor;
  final Color color;
  final VoidCallback? onPressed;
  final Size size;
  final double iconSize;
  final double touchPadding;
  final double padding;
  final Duration pressDelay;
  final bool enableHaptic;
  final Duration hapticDuration;
  final bool showFeedback;
  final String feedbackText;
  final double borderRadius;

  const AssistiveUIIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
    required this.iconColor,
    required this.color,
    required this.size,
    required this.iconSize,
    this.touchPadding = 0,
    this.padding = 0,
    this.borderRadius = 8,
    this.pressDelay = Duration.zero,
    this.enableHaptic = true,
    this.hapticDuration = const Duration(milliseconds: 0),
    this.showFeedback = true,
    this.feedbackText = "Icon button pressed",
  });

  @override
  State<AssistiveUIIconButton> createState() => _AssistiveUIIconButtonState();
}

class _AssistiveUIIconButtonState extends State<AssistiveUIIconButton> {
  bool _locked = false;

  static const prefix = "iconbutton";

  Future<void> _handlePress(
    BuildContext context,
    bool enableHaptic,
    bool showFeedback,
    Duration pressDelay,
  ) async {
    if (_locked || widget.onPressed == null) return;

    setState(() => _locked = true);

    if (pressDelay > Duration.zero) {
      await Future.delayed(pressDelay);
    }

    if (enableHaptic) {
      HapticFeedback.lightImpact();
      await Future.delayed(widget.hapticDuration);
    }

    widget.onPressed?.call();

    if (showFeedback) {
      showFloatingFeedback(context, widget.feedbackText);
    }

    if (mounted) setState(() => _locked = false);
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<UserComponentProvider>();

    final width = provider.getConfig<double>("${prefix}_width") ?? widget.size.width;
    final height = provider.getConfig<double>("${prefix}_height") ?? widget.size.height;
    final iconSize = provider.getConfig<double>("${prefix}_iconSize") ?? widget.iconSize;
    final touchPadding = provider.getConfig<double>("${prefix}_touchPadding") ?? widget.touchPadding;
    final padding = provider.getConfig<double>("${prefix}_padding") ?? widget.padding;
    final iconColor = provider.getConfig<Color>("${prefix}_iconColor") ?? widget.iconColor;
    final color = provider.getConfig<Color>("${prefix}_color") ?? widget.color;
    final enableHaptic = provider.getConfig<bool>("${prefix}_enableHaptic") ?? widget.enableHaptic;
    final showFeedback = provider.getConfig<bool>("${prefix}_showFeedback") ?? widget.showFeedback;
    final pressDelayMs = provider.getConfig<double>("${prefix}_pressDelay") ?? 0;
    final pressDelay = Duration(milliseconds: pressDelayMs.toInt());
    final borderRadius = provider.getConfig<double>("${prefix}_borderRadius") ?? widget.borderRadius;

    return Padding(
      padding: EdgeInsets.all(touchPadding),
      child: Material(
        color: color,
        borderRadius: BorderRadius.circular(borderRadius),
        child: InkWell(
          borderRadius: BorderRadius.circular(borderRadius),
          onTap: () => _handlePress(context, enableHaptic, showFeedback, pressDelay),
          child: Padding(
            padding: EdgeInsets.all(padding),
            child: SizedBox(
              width: width,
              height: height,
              child: Center(
                child: Icon(widget.icon, size: iconSize, color: iconColor, fontWeight: FontWeight.w700),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
