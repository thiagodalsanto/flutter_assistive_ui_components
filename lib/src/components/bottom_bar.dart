// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:flutter_assistive_ui_components/src/helpers/preset_size_multiplier.dart';
import 'package:flutter_assistive_ui_components/src/internal/floating_feedback.dart';
import 'package:flutter_assistive_ui_components/src/providers/providers.dart';

class AssistiveUIBottomBar extends StatefulWidget {
  final int currentIndex;
  final ValueChanged<int>? onChanged;
  final List<SalomonBottomBarItem> items;

  final Color backgroundColor;
  final Color inactiveColor;
  final Curve curve;
  final Duration animationDuration;
  final double selectedColorOpacity;

  final double itemPaddingHorizontal;
  final double itemPaddingVertical;
  final double margin;

  final ShapeBorder itemShape;
  final bool enableHaptic;
  final bool showFeedback;
  final Duration pressDelay;

  const AssistiveUIBottomBar({
    super.key,
    required this.currentIndex,
    required this.items,
    required this.onChanged,
    this.backgroundColor = const Color.fromARGB(50, 243, 243, 243),
    this.inactiveColor = Colors.grey,
    this.curve = Curves.easeInQuint,
    this.animationDuration = Duration.zero,
    this.selectedColorOpacity = 0.2,
    this.itemPaddingVertical = 12,
    this.itemPaddingHorizontal = 16,
    this.margin = 0,
    this.itemShape = const StadiumBorder(),
    this.enableHaptic = true,
    this.showFeedback = true,
    this.pressDelay = Duration.zero,
  });

  @override
  State<AssistiveUIBottomBar> createState() => _AssistiveUIBottomBarState();
}

class _AssistiveUIBottomBarState extends State<AssistiveUIBottomBar> {
  late int _currentIndex;

  static const prefix = "bottombar";

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.currentIndex;
  }

  Future<void> _handleTap(int index, bool enableHaptic, bool showFeedback, Duration delay) async {
    if (delay > Duration.zero) {
      await Future.delayed(delay);
    }

    if (enableHaptic) {
      HapticFeedback.selectionClick();
    }

    setState(() => _currentIndex = index);
    widget.onChanged?.call(index);

    if (showFeedback) {
      showFloatingFeedback(context, "Aba alterada", bottom: 80);
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<UserComponentProvider>();

    final backgroundColor =
        provider.getConfig<Color>("${prefix}_backgroundColor") ?? widget.backgroundColor;
    final inactiveColor = provider.getConfig<Color>("${prefix}_inactiveColor") ?? widget.inactiveColor;
    final enableHaptic = provider.getConfig<bool>("${prefix}_enableHaptic") ?? widget.enableHaptic;
    final showFeedback = provider.getConfig<bool>("${prefix}_showFeedback") ?? widget.showFeedback;
    final pressDelayMs = provider.getConfig<double>("${prefix}_pressDelay") ?? 0;
    final pressDelay = Duration(milliseconds: pressDelayMs.toInt());
    final opacity = provider.getConfig<double>("${prefix}_opacity") ?? widget.selectedColorOpacity;
    final itemPaddingVertical = getScaledPresetConfig(
      provider,
      prefix,
      'itemPaddingVertical',
      widget.itemPaddingVertical,
    );
    final itemPaddingHorizontal = getScaledPresetConfig(
      provider,
      prefix,
      'itemPaddingHorizontal',
      widget.itemPaddingHorizontal,
    );
    final margin = getScaledPresetConfig(provider, prefix, 'margin', widget.margin);

    return Container(
      margin: EdgeInsets.all(margin),
      decoration: BoxDecoration(color: backgroundColor),
      child: SalomonBottomBar(
        margin: EdgeInsets.zero,
        backgroundColor: backgroundColor,
        itemPadding: EdgeInsets.symmetric(
          horizontal: itemPaddingHorizontal,
          vertical: itemPaddingVertical,
        ),
        curve: widget.curve,
        selectedColorOpacity: opacity,
        itemShape: widget.itemShape,
        duration: widget.animationDuration,

        currentIndex: _currentIndex,
        onTap: (index) => _handleTap(index, enableHaptic, showFeedback, pressDelay),

        items:
            widget.items.map((item) {
              return SalomonBottomBarItem(
                icon: item.icon,
                activeIcon: item.activeIcon,
                title: item.title,
                selectedColor: item.selectedColor,
                unselectedColor: inactiveColor,
              );
            }).toList(),
      ),
    );
  }
}
