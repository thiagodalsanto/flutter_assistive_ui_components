# Changelog

## 1.2.0
- Color editor rebuilt for the Custom (Personalizado) mode: every color row
  (component colors and font colors alike) now opens a full RGB editor with
  R / G / B / A sliders in steps of 1, a live preview, a hexadecimal field
  (accepting #RGB, #RRGGBB and #AARRGGBB) and a row of quick color swatches
  — instead of the limited palette-only picker.
- Removed the `flutter_colorpicker` dependency; the editor is self-contained.

## 1.1.0
- Manual config sheet: size sliders now show GROWTH in % over the base (Fine)
  value instead of the raw dimension.
- Custom preset mode: saves a per-property size multiplier
  (`<component>_multiplier_<property>`) so the Fine base + chosen % is applied
  on the widget's real size (40% growth matches the Severe preset scale).
- Reopening the manual config sheet now shows the previously saved growth
  percentage per property.
- Preset presets (Fine/Aphasia/Severe) keep their global size multiplier
  behavior; custom mode zeroes it and takes over via per-property multipliers.

## 1.0.0
- Package first version
- Public Release