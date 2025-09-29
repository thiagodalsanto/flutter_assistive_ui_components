import 'package:flutter_assistive_ui_components/src/models/models.dart';
import 'package:flutter_assistive_ui_components/src/providers/providers.dart';

void applyPresetMap(UserComponentProvider p, Map<String, ComponentPreset> presets) {
  for (final entry in presets.entries) {
    final key = _normalize(entry.key);
    final preset = entry.value;

    // Aplica cada propriedade mapeada usando reflexão manual
    _applyProperty(p, key, 'width', preset.width);
    _applyProperty(p, key, 'height', preset.height);
    _applyProperty(p, key, 'fontSize', preset.fontSize);
    _applyProperty(p, key, 'iconSize', preset.iconSize);
    _applyProperty(p, key, 'scale', preset.scale);
    _applyProperty(p, key, 'touchPadding', preset.touchPadding);
    _applyProperty(p, key, 'padding', preset.padding);
    _applyProperty(p, key, 'pressDelay', preset.pressDelay);
    _applyProperty(p, key, 'enableHaptic', preset.enableHaptic);
    _applyProperty(p, key, 'showFeedback', preset.showFeedback);
    _applyProperty(p, key, 'color', preset.color);
    _applyProperty(p, key, 'fontColor', preset.fontColor);
    _applyProperty(p, key, 'activeColor', preset.activeColor);
    _applyProperty(p, key, 'inactiveColor', preset.inactiveColor);
    _applyProperty(p, key, 'colorPressed', preset.colorPressed);
    _applyProperty(p, key, 'iconColor', preset.iconColor);
    _applyProperty(p, key, 'borderRadius', preset.borderRadius);
    _applyProperty(p, key, 'hapticDuration', preset.hapticDuration);
    _applyProperty(p, key, 'showLabel', preset.showLabel);
    _applyProperty(p, key, 'animated', preset.isAnimated);
    _applyProperty(p, key, 'animationDuration', preset.animationDuration);
    _applyProperty(p, key, 'valueColor', preset.valueColor);
    _applyProperty(p, key, 'labelColor', preset.labelColor);
    _applyProperty(p, key, 'borderColor', preset.borderColor);
    _applyProperty(p, key, 'backgroundColor', preset.backgroundColor);
    _applyProperty(p, key, 'titleColor', preset.titleColor);
    _applyProperty(p, key, 'contentColor', preset.contentColor);
    _applyProperty(p, key, 'titleStyle', preset.titleStyle);
    _applyProperty(p, key, 'contentStyle', preset.contentStyle);
    _applyProperty(p, key, 'confirmWidth', preset.confirmWidth);
    _applyProperty(p, key, 'confirmHeight', preset.confirmHeight);
    _applyProperty(p, key, 'confirmBorderRadius', preset.confirmBorderRadius);
    _applyProperty(p, key, 'confirmBg', preset.confirmBackgroundColor);
    _applyProperty(p, key, 'confirmTextColor', preset.confirmTextColor);
    _applyProperty(p, key, 'cancelWidth', preset.cancelWidth);
    _applyProperty(p, key, 'cancelHeight', preset.cancelHeight);
    _applyProperty(p, key, 'cancelBorderRadius', preset.cancelBorderRadius);
    _applyProperty(p, key, 'cancelBg', preset.cancelBackgroundColor);
    _applyProperty(p, key, 'cancelTextColor', preset.cancelTextColor);
    _applyProperty(p, key, 'showIcon', preset.showIcon);
    _applyProperty(p, key, 'itemPaddingHorizontal', preset.itemPaddingHorizontal);
    _applyProperty(p, key, 'itemPaddingVertical', preset.itemPaddingVertical);
    _applyProperty(p, key, 'margin', preset.margin);
    _applyProperty(p, key, 'selectedColorOpacity', preset.selectedColorOpacity);
    _applyProperty(p, key, 'size', preset.size);
    _applyProperty(p, key, 'listColor', preset.listColor);

    // Propriedades opcionais
    if (preset.days != null) _applyProperty(p, key, 'days', preset.days);
    if (preset.daySize != null) _applyProperty(p, key, 'daySize', preset.daySize);
  }
}

/// Helper para aplicar propriedade apenas se não for null
void _applyProperty(UserComponentProvider p, String componentKey, String propertyKey, dynamic value) {
  if (value != null) {
    p.setConfig("${componentKey}_$propertyKey", value);
  }
}

String _normalize(String c) => c.toLowerCase().replaceAll(" ", "");
