// ignore_for_file: deprecated_member_use

import 'package:flutter_assistive_ui_components/src/internal/assistive_button/accessibility_presets_sheet/accessibility_preset_sheet.dart';
import 'package:flutter/material.dart';

/// =======================================================
/// Floating Assistive Button
///
/// A draggable floating action button that provides access to
/// a component configuration system.
///
/// Features:
/// - Draggable position on screen
/// - Opens accessibility preset sheet
/// - Entry point for dynamic UI configuration
/// - Global access to design system controls
///
/// Designed as a developer/preview tool for interacting
/// with the component system at runtime.
/// =======================================================

class FloatingAssistiveButton extends StatefulWidget {
  final bool enabled;
  final Offset initialPosition;
  final double size;
  final Color color;
  final Widget child;
  final GlobalKey<NavigatorState>? navigatorKey;

  const FloatingAssistiveButton({
    super.key,
    required this.child,
    required this.enabled,
    required this.initialPosition,
    this.size = 72,
    this.color = Colors.blue,
    this.navigatorKey,
  });

  @override
  State<FloatingAssistiveButton> createState() => _FloatingAssistiveButtonState();
}

class _FloatingAssistiveButtonState extends State<FloatingAssistiveButton> {
  late Offset position;
  bool _isPresetSheetOpen = false;

  @override
  void initState() {
    super.initState();
    position = widget.initialPosition;
  }

  Future<void> _openComponentSheet(BuildContext context) async {
    if (_isPresetSheetOpen) return;

    final navigatorContext = widget.navigatorKey?.currentContext ?? context;
    setState(() => _isPresetSheetOpen = true);

    try {
      await showModalBottomSheet<void>(
        context: navigatorContext,
        isScrollControlled: true,
        isDismissible: true,
        enableDrag: true,
        backgroundColor: Colors.transparent,
        builder: (_) => const AccessibilityPresetSheet(),
      );
    } finally {
      if (mounted) setState(() => _isPresetSheetOpen = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.enabled || _isPresetSheetOpen) return const SizedBox.shrink();

    return Positioned(
      left: position.dx,
      top: position.dy,
      child: GestureDetector(
        onPanUpdate: (d) => setState(() => position += d.delta),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(22),
            onTap: () => _openComponentSheet(context),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 150),
              width: widget.size,
              height: widget.size,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [widget.color, widget.color.withOpacity(0.8)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(22),
                boxShadow: const [
                  BoxShadow(color: Colors.black26, blurRadius: 12, offset: Offset(0, 6)),
                ],
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Center(child: widget.child),
                  Positioned(
                    bottom: 6,
                    child: Container(
                      width: 20,
                      height: 3,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.6),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
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
