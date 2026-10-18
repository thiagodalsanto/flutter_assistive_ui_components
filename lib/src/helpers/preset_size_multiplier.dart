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
  // Escala de texto de página (títulos, subtítulos, listas etc.) usada
  // pelo app através de um MediaQuery com TextScaler por preset.
  'pagetext',
];

void applyPresetSizeMultiplier(
  UserComponentProvider provider,
  double multiplier,
) {
  for (final prefix in presetScalableComponentPrefixes) {
    provider.setConfig('${prefix}_$presetSizeMultiplierProperty', multiplier);
  }
}

double getPresetSizeMultiplier(UserComponentProvider provider, String prefix) {
  return provider
          .getConfig<num>('${prefix}_$presetSizeMultiplierProperty')
          ?.toDouble() ??
      1.0;
}

/// Multiplicador por propriedade (usado pelo modo Personalizado, onde o
/// Fine — valor base do widget — é somado do crescimento escolhido).
double getPropSizeMultiplier(
  UserComponentProvider provider,
  String prefix,
  String property,
) {
  return provider
          .getConfig<num>('${prefix}_multiplier_$property')
          ?.toDouble() ??
      1.0;
}

double getScaledPresetConfig(
  UserComponentProvider provider,
  String prefix,
  String property,
  double fallback,
) {
  final globalMultiplier = getPresetSizeMultiplier(provider, prefix);
  final propMultiplier = getPropSizeMultiplier(provider, prefix, property);
  // No modo Personalizado (global 1.0), vale o crescimento por prop honrando
  // a base do widget; nos presets, vale o multiplicador global do preset.
  final multiplier = propMultiplier != 1.0 ? propMultiplier : globalMultiplier;
  final value =
      provider.getConfig<num>('${prefix}_$property')?.toDouble() ?? fallback;
  return value * multiplier;
}
