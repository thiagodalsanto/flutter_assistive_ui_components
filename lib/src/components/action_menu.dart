import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_assistive_ui_components/src/helpers/preset_size_multiplier.dart';
import 'package:flutter_assistive_ui_components/src/internal/floating_feedback.dart';
import 'package:flutter_assistive_ui_components/src/providers/providers.dart';
import 'package:provider/provider.dart';

class AssistiveUIActionMenuItem {
  const AssistiveUIActionMenuItem({
    required this.label,
    required this.icon,
    required this.onPressed,
    this.backgroundColor,
    this.foregroundColor,
  });

  final String label;
  final IconData icon;
  final VoidCallback onPressed;
  final Color? backgroundColor;
  final Color? foregroundColor;
}

class AssistiveUIActionMenu extends StatefulWidget {
  const AssistiveUIActionMenu({
    required this.label,
    required this.children,
    super.key,
    this.activeLabel,
    this.size = const Size(160, 56),
    this.itemSize = 56,
    this.iconSize = 24,
    this.fontSize = 14,
    this.spacing = 12,
    this.color = Colors.blue,
    this.fontColor = Colors.white,
    this.itemColor = Colors.blue,
    this.itemFontColor = Colors.white,
    this.enableHaptic = false,
    this.showFeedback = false,
    this.feedbackText = 'Menu de ações',
    this.pressDelay = Duration.zero,
    this.hapticDuration = const Duration(milliseconds: 30),
    this.elevation = 6,
  });

  final String label;
  final String? activeLabel;
  final List<AssistiveUIActionMenuItem> children;
  final Size size;
  final double itemSize;
  final double iconSize;
  final double fontSize;
  final double spacing;
  final Color color;
  final Color fontColor;
  final Color itemColor;
  final Color itemFontColor;
  final bool enableHaptic;
  final bool showFeedback;
  final String feedbackText;
  final Duration pressDelay;
  final Duration hapticDuration;
  final double elevation;

  @override
  State<AssistiveUIActionMenu> createState() => _AssistiveUIActionMenuState();
}

class _AssistiveUIActionMenuState extends State<AssistiveUIActionMenu>
    with SingleTickerProviderStateMixin {
  static const _prefix = 'actionmenu';

  bool _isOpen = false;
  bool _isLocked = false;
  late final AnimationController _menuController;

  @override
  void initState() {
    super.initState();
    _menuController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 180),
    );
  }

  @override
  void dispose() {
    _menuController.dispose();
    super.dispose();
  }

  void _toggleMenu() {
    setState(() => _isOpen = !_isOpen);
    if (_isOpen) {
      _menuController.forward();
    } else {
      _menuController.reverse();
    }
  }

  void _closeMenu() {
    if (!_isOpen) return;
    setState(() => _isOpen = false);
    _menuController.reverse();
  }

  Future<void> _interact(VoidCallback onAction, {
    required bool enableHaptic,
    required bool showFeedback,
    required Duration pressDelay,
    required Duration hapticDuration,
    required String feedbackText,
  }) async {
    if (_isLocked) return;
    setState(() => _isLocked = true);

    try {
      if (pressDelay > Duration.zero) {
        await Future.delayed(pressDelay);
      }
      if (!mounted) return;
      if (enableHaptic) {
        await HapticFeedback.mediumImpact();
        await Future.delayed(hapticDuration);
      }
      if (!mounted) return;
      onAction();
      if (showFeedback && mounted) {
        showFloatingFeedback(context, feedbackText);
      }
    } finally {
      if (mounted) setState(() => _isLocked = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<UserComponentProvider>();
    final width = getScaledPresetConfig(provider, _prefix, 'width', widget.size.width);
    final height = getScaledPresetConfig(provider, _prefix, 'height', widget.size.height);
    final itemSize = getScaledPresetConfig(provider, _prefix, 'itemSize', widget.itemSize);
    final iconSize = getScaledPresetConfig(provider, _prefix, 'iconSize', widget.iconSize);
    final fontSize = getScaledPresetConfig(provider, _prefix, 'fontSize', widget.fontSize);
    final spacing = getScaledPresetConfig(provider, _prefix, 'spacing', widget.spacing);
    final horizontalPadding = getScaledPresetConfig(provider, _prefix, 'padding', 12);
    final buttonPadding = getScaledPresetConfig(provider, _prefix, 'buttonPadding', 16);
    final labelIconSpacing = getScaledPresetConfig(provider, _prefix, 'labelIconSpacing', 12);
    final borderRadius = getScaledPresetConfig(provider, _prefix, 'borderRadius', 8);
    final color = provider.getConfig<Color>('${_prefix}_color') ?? widget.color;
    final fontColor = provider.getConfig<Color>('${_prefix}_fontColor') ?? widget.fontColor;
    final enableHaptic = provider.getConfig<bool>('${_prefix}_enableHaptic') ?? widget.enableHaptic;
    final showFeedback = provider.getConfig<bool>('${_prefix}_showFeedback') ?? widget.showFeedback;
    final pressDelayMs = provider.getConfig<num>('${_prefix}_pressDelay')?.toInt() ??
        widget.pressDelay.inMilliseconds;
    final pressDelay = Duration(milliseconds: pressDelayMs);
    final hapticDurationMs = provider.getConfig<num>('${_prefix}_hapticDuration')?.toInt() ??
        widget.hapticDuration.inMilliseconds;
    final hapticDuration = Duration(milliseconds: hapticDurationMs);
    final elevation = provider.getConfig<num>('${_prefix}_elevation')?.toDouble() ??
        widget.elevation;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        for (final item in widget.children.reversed)
          AnimatedSize(
            duration: const Duration(milliseconds: 180),
            curve: Curves.easeOut,
            child: _isOpen
                ? Padding(
                    padding: EdgeInsets.only(bottom: spacing),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Material(
                          elevation: 2,
                          color: item.backgroundColor ?? widget.itemColor,
                          borderRadius: BorderRadius.circular(borderRadius),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: horizontalPadding,
                              vertical: horizontalPadding * 2 / 3,
                            ),
                            child: Text(
                              item.label,
                              style: TextStyle(
                                color: item.foregroundColor ?? widget.itemFontColor,
                                fontSize: fontSize,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: labelIconSpacing),
                        Material(
                          color: item.backgroundColor ?? widget.itemColor,
                          shape: const CircleBorder(),
                          elevation: elevation,
                          child: InkWell(
                            customBorder: const CircleBorder(),
                            onTap: _isLocked
                                ? null
                                : () => _interact(
                                      () {
                                        _closeMenu();
                                        item.onPressed();
                                      },
                                      enableHaptic: enableHaptic,
                                      showFeedback: showFeedback,
                                      pressDelay: pressDelay,
                                      hapticDuration: hapticDuration,
                                      feedbackText: item.label,
                                    ),
                            child: SizedBox(
                              width: itemSize,
                              height: itemSize,
                              child: Icon(
                                item.icon,
                                size: iconSize,
                                color: item.foregroundColor ?? widget.itemFontColor,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                : const SizedBox.shrink(),
          ),
        Material(
          color: color,
          borderRadius: BorderRadius.circular(height / 2),
          elevation: elevation,
          child: InkWell(
            borderRadius: BorderRadius.circular(height / 2),
            onTap: _isLocked
                ? null
                : () => _interact(
                      _toggleMenu,
                      enableHaptic: enableHaptic,
                      showFeedback: showFeedback,
                      pressDelay: pressDelay,
                      hapticDuration: hapticDuration,
                      feedbackText: widget.feedbackText,
                    ),
            child: SizedBox(
              width: width,
              height: height,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: buttonPadding),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          _isOpen ? widget.activeLabel ?? widget.label : widget.label,
                          maxLines: 1,
                          style: TextStyle(color: fontColor, fontSize: fontSize),
                        ),
                      ),
                    ),
                    SizedBox(width: labelIconSpacing * 2 / 3),
                    AnimatedIcon(
                      icon: AnimatedIcons.menu_close,
                      progress: _menuController,
                      color: fontColor,
                      size: iconSize,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
