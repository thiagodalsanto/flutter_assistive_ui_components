import 'package:flutter_assistive_ui_components/src/providers/providers.dart';
import 'package:flutter_assistive_ui_components/src/helpers/preset_size_multiplier.dart';
import 'package:flutter_assistive_ui_components/src/presets/models.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void applyPreset(BuildContext context, String preset) {
  final p = Provider.of<UserComponentProvider>(context, listen: false);

  if (!const {"aphasia", "severe_motor", "fine_motor"}.contains(preset)) {
    throw ArgumentError.value(preset, 'preset', 'Preset de acessibilidade desconhecido');
  }

  p.clearConfigs();
  switch (preset) {
    case "aphasia":
      applyAphasia(p);
      break;
    case "severe_motor":
      applySevereMotor(p);
      break;
    case "fine_motor":
      applyFineMotor(p);
      break;
  }

  p.setConfig('activePreset', preset);
  Navigator.pop(context);
}

void applyCustomPreset(BuildContext context) {
  final p = Provider.of<UserComponentProvider>(context, listen: false);
  applyPresetSizeMultiplier(p, 1.0);
  p.setConfig('activePreset', 'custom');
}
