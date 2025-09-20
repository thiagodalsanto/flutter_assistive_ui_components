// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'package:flutter_assistive_ui_components/src/internal/floating_feedback.dart';
import 'package:flutter_assistive_ui_components/src/providers/providers.dart';

/// =======================================================
/// Custom Dropdown Component
///
/// A configurable dropdown widget with support for:
/// - Generic type selection
/// - External value control via callback
/// - Global styling via UserComponentProvider
/// - Optional haptic feedback
/// - Optional floating feedback messages
/// - Delayed selection handling
///
/// Designed for design systems where dropdown behavior
/// and appearance can be centrally managed.
/// =======================================================

class AssistiveUIDropdown<T> extends StatefulWidget {
  final T value;
  final List<DropdownMenuItem<T>> items;
  final ValueChanged<T>? onChanged;

  final double width;
  final double height;
  final double touchPadding;
  final double padding;
  final Duration pressDelay;
  final bool enableHaptic;
  final Duration hapticDuration;
  final bool showFeedback;
  final Color color;
  final Color listColor;
  final String feedbackText;
  final Widget icon;

  const AssistiveUIDropdown({
    super.key,
    required this.value,
    required this.items,
    required this.onChanged,
    this.width = 200,
    this.height = 56,
    this.touchPadding = 8,
    this.padding = 0,
    this.pressDelay = Duration.zero,
    this.enableHaptic = false,
    this.hapticDuration = const Duration(milliseconds: 30),
    this.showFeedback = false,
    this.color = Colors.blue,
    this.listColor = Colors.white,
    this.feedbackText = "Dropdown Selected",
    this.icon = const Icon(Icons.arrow_drop_down),
  });

  @override
  State<AssistiveUIDropdown<T>> createState() => _AssistiveUIDropdownState<T>();
}

class _AssistiveUIDropdownState<T> extends State<AssistiveUIDropdown<T>> {
  late T _currentValue;

  static const prefix = "dropdown";

  @override
  void initState() {
    super.initState();
    _currentValue = widget.value;
  }

  Future<void> _handleChange(
    T? newValue,
    bool enableHaptic,
    bool showFeedback,
    Duration pressDelay,
  ) async {
    if (newValue == null) return;

    if (pressDelay > Duration.zero) {
      await Future.delayed(pressDelay);
    }

    if (enableHaptic) {
      HapticFeedback.selectionClick();
      await Future.delayed(widget.hapticDuration);
    }

    setState(() => _currentValue = newValue);
    widget.onChanged?.call(newValue);

    if (showFeedback) {
      showFloatingFeedback(context, widget.feedbackText);
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<UserComponentProvider>();
    final GlobalKey dropdownKey = GlobalKey();

    final width = provider.getConfig<double>("${prefix}_width") ?? widget.width;
    final height = provider.getConfig<double>("${prefix}_height") ?? widget.height;
    final touchPadding = provider.getConfig<double>("${prefix}_touchPadding") ?? widget.touchPadding;
    final padding = provider.getConfig<double>("${prefix}_padding") ?? widget.padding;
    final color = provider.getConfig<Color>("${prefix}_color") ?? widget.color;
    final listColor = provider.getConfig<Color>("${prefix}_listColor") ?? widget.listColor;
    final enableHaptic = provider.getConfig<bool>("${prefix}_enableHaptic") ?? widget.enableHaptic;
    final showFeedback = provider.getConfig<bool>("${prefix}_showFeedback") ?? widget.showFeedback;
    final pressDelayMs =
        provider.getConfig<double>("${prefix}_pressDelay") ?? widget.pressDelay.inMilliseconds;
    final pressDelay = Duration(milliseconds: pressDelayMs.toInt());

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        dropdownKey.currentContext?.findRenderObject();
      },
      child: Padding(
        padding: EdgeInsets.all(touchPadding),
        child: Container(
          padding: EdgeInsets.all(padding),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
          child: SizedBox(
            width: width,
            height: height,
            child: DropdownButtonFormField<T>(
              key: dropdownKey,
              dropdownColor: listColor,
              isExpanded: true,
              initialValue: _currentValue,
              items: widget.items,
              onChanged: (v) => _handleChange(v, enableHaptic, showFeedback, pressDelay),
              icon: widget.icon,
              decoration: InputDecoration(
                isDense: true,
                contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: (height - 24) / 2),
                border: OutlineInputBorder(borderSide: BorderSide(color: color)),
                enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: color)),
                focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: color, width: 2)),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
