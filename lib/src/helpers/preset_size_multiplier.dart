import 'package:flutter_assistive_ui_components/src/providers/providers.dart';

const String presetSizeMultiplierProperty = 'presetSizeMultiplier';

const List<String> presetScalableComponentPrefixes = [
  'button',
  'actionmenu',
  'bigbutton',
  'textbutton',
  'iconbutton',
  'linearprogress',
  'alertdialog',
  'tabbar',
  'bottombar',
  'checkbox',
  'radio',
  'slider',
  'switch',
  'textfield',
  'dropdown',
  'timepicker',
  'overviewcard',
  'taskcard',
  'sidemenu',
];

void applyPresetSizeMultiplier(UserComponentProvider provider, double multiplier) {
  for (final prefix in presetScalableComponentPrefixes) {
    provider.setConfig('${prefix}_$presetSizeMultiplierProperty', multiplier);
  }
}

double getPresetSizeMultiplier(UserComponentProvider provider, String prefix) {
  return provider.getConfig<num>('${prefix}_$presetSizeMultiplierProperty')?.toDouble() ?? 1.0;
}

double getScaledPresetConfig(
  UserComponentProvider provider,
  String prefix,
  String property,
  double fallback,
) {
  final value = provider.getConfig<num>('${prefix}_$property')?.toDouble() ?? fallback;
  return value * getPresetSizeMultiplier(provider, prefix);
}
