import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_assistive_ui_components/src/helpers/preset_size_multiplier.dart';
import 'package:flutter_assistive_ui_components/src/providers/providers.dart';

class AssistiveUISideMenu extends StatelessWidget {
  const AssistiveUISideMenu({required this.child, super.key, this.backgroundColor, this.width = 304});

  final Widget child;
  final Color? backgroundColor;
  final double width;

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<UserComponentProvider>();
    const prefix = 'sidemenu';
    final multiplier = getPresetSizeMultiplier(provider, prefix);
    final configuredWidth = provider.getConfig<num>('${prefix}_width')?.toDouble() ?? width;
    final configuredBackgroundColor =
        provider.getConfig<Color>('${prefix}_backgroundColor') ?? backgroundColor;

    return Drawer(
      width: configuredWidth,
      backgroundColor: configuredBackgroundColor,
      child: SafeArea(
        child: MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaler: TextScaler.linear(multiplier)),
          child: child,
        ),
      ),
    );
  }
}
