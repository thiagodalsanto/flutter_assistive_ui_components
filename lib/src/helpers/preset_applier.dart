import 'package:flutter_assistive_ui_components/src/providers/providers.dart';
import 'package:flutter_assistive_ui_components/src/presets/models.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void applyPreset(BuildContext context, String preset) {
  final p = Provider.of<UserComponentProvider>(context, listen: false);

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

  Navigator.pop(context);
}
