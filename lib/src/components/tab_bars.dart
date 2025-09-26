// ignore_for_file: use_build_context_synchronously, deprecated_member_use

import 'package:flutter_assistive_ui_components/src/models/models.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'package:flutter_assistive_ui_components/src/internal/floating_feedback.dart';
import 'package:flutter_assistive_ui_components/src/providers/providers.dart';

class AssistiveUITabBar extends StatefulWidget {
  final List<TabItem> items;
  final int currentIndex;
  final ValueChanged<int>? onChanged;
  final double height;
  final double padding;
  final bool enableHaptic;
  final bool showFeedback;
  final bool showIcon;

  final Duration pressDelay;

  const AssistiveUITabBar({
    super.key,
    required this.items,
    required this.currentIndex,
    required this.onChanged,
    this.height = 64,
    this.padding = 8,
    this.enableHaptic = true,
    this.showIcon = true,
    this.showFeedback = true,
    this.pressDelay = Duration.zero,
  });

  @override
  State<AssistiveUITabBar> createState() => _AssistiveUITabBarState();
}

class _AssistiveUITabBarState extends State<AssistiveUITabBar> {
  late int _index;

  static const prefix = "tabbar";

  @override
  void initState() {
    super.initState();
    _index = widget.currentIndex;
  }

  Future<void> _handleTap(int index, bool enableHaptic, bool showFeedback, Duration delay) async {
    if (delay > Duration.zero) {
      await Future.delayed(delay);
    }

    if (enableHaptic) {
      HapticFeedback.selectionClick();
    }

    setState(() => _index = index);
    widget.onChanged?.call(index);

    if (showFeedback) {
      showFloatingFeedback(context, "Tab: ${widget.items[index].label}");
    }
  }

  @override
  Widget build(BuildContext context) {
    final p = context.watch<UserComponentProvider>();

    final height = p.getConfig<double>("${prefix}_height") ?? widget.height;
    final padding = p.getConfig<double>("${prefix}_padding") ?? widget.padding;
    final backgroundColor = p.getConfig<Color>("${prefix}_backgroundColor") ?? Colors.white;
    final inactiveColor = p.getConfig<Color>("${prefix}_inactiveColor") ?? Colors.grey;
    final enableHaptic = p.getConfig<bool>("${prefix}_enableHaptic") ?? widget.enableHaptic;
    final showFeedback = p.getConfig<bool>("${prefix}_showFeedback") ?? widget.showFeedback;
    final showIcon = p.getConfig<bool>("${prefix}_showIcon") ?? widget.showIcon;
    final pressDelayMs = p.getConfig<double>("${prefix}_pressDelay") ?? 0;
    final pressDelay = Duration(milliseconds: pressDelayMs.toInt());

    Color resolveActiveColor(TabItem item) {
      return item.activeColor ?? p.getConfig<Color>("${prefix}_activeColor") ?? Colors.blue;
    }

    Color resolveInactiveColor(TabItem item) {
      return item.inactiveColor ?? inactiveColor;
    }

    return SafeArea(
      top: false,
      child: Container(
        height: height,
        decoration: BoxDecoration(
          color: backgroundColor,
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 0),
              blurRadius: 50,
              spreadRadius: 1,
              color: Colors.black.withOpacity(0.15),
            ),
          ],
        ),
        child: Row(
          children: List.generate(widget.items.length, (i) {
            final item = widget.items[i];
            final selected = i == _index;

            final activeColor = resolveActiveColor(item);
            final inactive = resolveInactiveColor(item);

            return Expanded(
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () => _handleTap(i, enableHaptic, showFeedback, pressDelay),
                child: Padding(
                  padding: EdgeInsets.all(padding),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              if (showIcon)
                                Icon(item.icon, size: 20, color: selected ? activeColor : inactive),
                              if (showIcon) const SizedBox(width: 6),
                              Flexible(
                                child: Text(
                                  item.label,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize:
                                        (height >= 76
                                            ? 18
                                            : height <= 75 && height > 64 && !showIcon
                                            ? 16
                                            : 14),
                                    color: selected ? activeColor : inactive,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      AnimatedContainer(
                        duration: const Duration(milliseconds: 250),
                        height: 3,
                        width: double.infinity,
                        margin: const EdgeInsets.only(top: 6),
                        decoration: BoxDecoration(
                          color: selected ? activeColor : Colors.transparent,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
