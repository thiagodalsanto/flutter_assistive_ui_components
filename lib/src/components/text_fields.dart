// ignore_for_file: use_build_context_synchronously, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'package:flutter_assistive_ui_components/src/internal/floating_feedback.dart';
import 'package:flutter_assistive_ui_components/src/providers/providers.dart';

/// =======================================================
/// Custom TextField Component
///
/// A configurable text input widget with support for:
/// - External controller management
/// - Focus handling via tap interaction
/// - Global styling via UserComponentProvider
/// - Optional haptic feedback
/// - Optional floating feedback messages
/// - Press delay animation support
///
/// Designed for reusable form systems where input fields
/// need consistent behavior and centralized styling control.
/// =======================================================

class AssistiveUITextField extends StatefulWidget {
  final String label;
  final TextEditingController controller;

  final double height;
  final double width;
  final double touchPadding;
  final double padding;
  final Duration pressDelay;
  final bool enableHaptic;
  final Duration hapticDuration;
  final bool showFeedback;
  final String feedbackText;
  final Color color;
  final FocusNode? focusNode;

  const AssistiveUITextField({
    super.key,
    required this.label,
    required this.controller,
    this.height = 56,
    this.width = 200,
    this.padding = 8,
    this.touchPadding = 12,
    this.pressDelay = Duration.zero,
    this.enableHaptic = false,
    this.hapticDuration = const Duration(milliseconds: 30),
    this.showFeedback = false,
    this.feedbackText = "Textfield Activated",
    this.color = Colors.blue,
    this.focusNode,
  });

  @override
  State<AssistiveUITextField> createState() => _AssistiveUITextFieldState();
}

class _AssistiveUITextFieldState extends State<AssistiveUITextField> {
  bool _pressed = false;
  final FocusNode _focusNode = FocusNode();

  static const String prefix = "textfield";

  Future<void> _handleTap(
    BuildContext context, {
    required Duration pressDelay,
    required bool enableHaptic,
    required Duration hapticDuration,
    required bool showFeedback,
  }) async {
    if (pressDelay > Duration.zero) {
      setState(() => _pressed = true);
      await Future.delayed(pressDelay);
    }

    if (enableHaptic) {
      HapticFeedback.lightImpact();
      await Future.delayed(hapticDuration);
    }

    (widget.focusNode ?? _focusNode).requestFocus();

    if (showFeedback) {
      showFloatingFeedback(context, widget.feedbackText);
    }

    setState(() => _pressed = false);
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<UserComponentProvider>();
    final FocusNode effectiveFocusNode = widget.focusNode ?? _focusNode;

    final height = provider.getConfig<double>("${prefix}_height") ?? widget.height;
    final width = provider.getConfig<double>("${prefix}_width") ?? widget.width;
    final touchPadding = provider.getConfig<double>("${prefix}_touchPadding") ?? widget.touchPadding;
    final padding = provider.getConfig<double>("${prefix}_padding") ?? widget.padding;
    final pressDelayMs =
        provider.getConfig<double>("${prefix}_pressDelay") ?? widget.pressDelay.inMilliseconds;
    final enableHaptic = provider.getConfig<bool>("${prefix}_enableHaptic") ?? widget.enableHaptic;
    final showFeedback = provider.getConfig<bool>("${prefix}_showFeedback") ?? widget.showFeedback;
    final color = provider.getConfig<Color>("${prefix}_color") ?? widget.color;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap:
          () => _handleTap(
            context,
            pressDelay: Duration(milliseconds: pressDelayMs.toInt()),
            enableHaptic: enableHaptic,
            hapticDuration: widget.hapticDuration,
            showFeedback: showFeedback,
          ),
      child: Padding(
        padding: EdgeInsets.all(touchPadding),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 100),
          padding: EdgeInsets.all(padding),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0 + padding),
            boxShadow:
                _pressed
                    ? [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.15),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ]
                    : [],
          ),
          child: SizedBox(
            height: height,
            width: width,
            child: TextField(
              controller: widget.controller,
              focusNode: effectiveFocusNode,
              expands: true,
              maxLines: null,
              minLines: null,
              decoration: InputDecoration(
                isDense: true,
                labelText: widget.label,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: color, width: 2),
                  borderRadius: BorderRadius.circular(8),
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: padding, vertical: padding),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
