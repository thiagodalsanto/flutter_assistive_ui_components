# Changelog

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