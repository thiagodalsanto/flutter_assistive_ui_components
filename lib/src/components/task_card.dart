import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_assistive_ui_components/src/helpers/preset_size_multiplier.dart';
import 'package:flutter_assistive_ui_components/src/providers/providers.dart';

class AssistiveUITaskCard extends StatelessWidget {
  const AssistiveUITaskCard({
    required this.child,
    required this.actionBarText,
    required this.actionBarColor,
    super.key,
    this.backgroundColor,
    this.actionBarIcon,
    this.actionBarOnPressed,
    this.padding = 16,
    this.actionBarHeight = 48,
  });

  final Widget child;
  final String actionBarText;
  final Color actionBarColor;
  final Color? backgroundColor;
  final IconData? actionBarIcon;
  final VoidCallback? actionBarOnPressed;
  final double padding;
  final double actionBarHeight;

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<UserComponentProvider>();
    const prefix = 'taskcard';
    final multiplier = getPresetSizeMultiplier(provider, prefix);
    final scaledPadding = getScaledPresetConfig(
      provider,
      prefix,
      'padding',
      padding,
    );
    final scaledActionBarHeight = getScaledPresetConfig(
      provider,
      prefix,
      'actionBarHeight',
      actionBarHeight,
    );
    final configuredBackgroundColor =
        provider.getConfig<Color>('${prefix}_backgroundColor') ??
        backgroundColor;
    final configuredActionBarColor =
        provider.getConfig<Color>('${prefix}_actionBarColor') ?? actionBarColor;

    return Card(
      color: configuredBackgroundColor,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MediaQuery(
            data: MediaQuery.of(
              context,
            ).copyWith(textScaler: TextScaler.linear(multiplier)),
            child: Padding(
              padding: EdgeInsets.all(scaledPadding),
              child: child,
            ),
          ),
          SizedBox(
            height: scaledActionBarHeight,
            child: TextButton(
              style: TextButton.styleFrom(
                minimumSize: Size.fromHeight(scaledActionBarHeight),
                backgroundColor: configuredActionBarColor,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(12),
                  ),
                ),
              ),
              onPressed: actionBarOnPressed,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(actionBarText),
                  SizedBox(width: 8 * multiplier),
                  if (actionBarIcon != null) ...[
                    Icon(actionBarIcon, size: 24 * multiplier),
                    SizedBox(width: 8 * multiplier),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
