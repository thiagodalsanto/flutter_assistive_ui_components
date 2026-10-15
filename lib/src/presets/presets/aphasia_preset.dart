import 'package:flutter/material.dart';
import 'package:flutter_assistive_ui_components/src/helpers/preset_mapper.dart';
import 'package:flutter_assistive_ui_components/src/helpers/preset_size_multiplier.dart';
import 'package:flutter_assistive_ui_components/src/models/models.dart';
import 'package:flutter_assistive_ui_components/src/presets/base_values.dart';
import 'package:flutter_assistive_ui_components/src/providers/providers.dart';

void applyAphasia(UserComponentProvider p) {
  const defaultAphasiaColor = Colors.deepPurple;

  applyPresetSizeMultiplier(p, 1.2);

  applyPresetMap(p, {
    "Action Menu": ComponentPreset(
      pressDelay: PresetDefaults.defaultPressDelayAphasia,
      enableHaptic: !PresetDefaults.defaultMultiModalFeedback,
      showFeedback: !PresetDefaults.defaultMultiModalFeedback,
    ),
    "Button": ComponentPreset(
      // fontColor: PresetDefaults.buttonDefaultFontColor,
      pressDelay: PresetDefaults.defaultPressDelayAphasia,
      showFeedback: !PresetDefaults.defaultMultiModalFeedback,
      enableHaptic: !PresetDefaults.defaultMultiModalFeedback,
      // color: defaultAphasiaColor,
    ),

    "Big Button": ComponentPreset(
      // fontColor: PresetDefaults.buttonDefaultFontColor,
      pressDelay: PresetDefaults.defaultPressDelayAphasia,
      showFeedback: !PresetDefaults.defaultMultiModalFeedback,
      enableHaptic: !PresetDefaults.defaultMultiModalFeedback,
      // color: defaultAphasiaColor,
    ),

    "Text Button": ComponentPreset(
      // fontColor: PresetDefaults.textButtonDefaultFontColor,
      pressDelay: PresetDefaults.defaultPressDelayAphasia,
      showFeedback: !PresetDefaults.defaultMultiModalFeedback,
      enableHaptic: !PresetDefaults.defaultMultiModalFeedback,
    ),

    "Icon Button": ComponentPreset(
      pressDelay: PresetDefaults.defaultPressDelayAphasia,
      enableHaptic: !PresetDefaults.defaultMultiModalFeedback,
      showFeedback: !PresetDefaults.defaultMultiModalFeedback,
      iconColor: PresetDefaults.buttonDefaultFontColor,
      // color: defaultAphasiaColor,
    ),

    "Linear Progress": ComponentPreset(
      color: PresetDefaults.linearProgressDefaultColor,
      showLabel: PresetDefaults.linearProgressDefaultShowLabel,
      isAnimated: PresetDefaults.linearProgressDefaultIsAnimated,
      animationDuration: PresetDefaults.defaultAnimationDuration,
      borderColor: PresetDefaults.linearProgressDefaultBorderColor,
      // valueColor: defaultAphasiaColor,
      // labelColor: defaultAphasiaColor,
    ),

    "Alert Dialog": ComponentPreset(
      enableHaptic: !PresetDefaults.defaultMultiModalFeedback,
      showFeedback: !PresetDefaults.defaultMultiModalFeedback,
      backgroundColor: PresetDefaults.alertDialogBackgroundColor,
      titleColor: PresetDefaults.alertDialogTitleColor,
      contentColor: PresetDefaults.alertDialogContentColor,
      titleStyle: PresetDefaults.alertDialogTitleStyle,
      contentStyle: PresetDefaults.alertDialogContentStyle,
      confirmBackgroundColor: PresetDefaults.alertDialogConfirmBackgroundColor,
      confirmTextColor: PresetDefaults.alertDialogCancelTextColor,
      cancelBackgroundColor: PresetDefaults.alertDialogCancelBackgroundColor,
      cancelTextColor: PresetDefaults.alertDialogCancelTextColor,
    ),

    "Tab Bar": ComponentPreset(
      pressDelay: PresetDefaults.defaultPressDelayAphasia,
      enableHaptic: !PresetDefaults.defaultMultiModalFeedback,
      showFeedback: !PresetDefaults.defaultMultiModalFeedback,
      showIcon: !PresetDefaults.defaultMultiModalFeedback,
    ),

    "Bottom Bar": ComponentPreset(
      inactiveColor: PresetDefaults.defaultInactiveColor,
      pressDelay: PresetDefaults.defaultPressDelayAphasia,
      enableHaptic: !PresetDefaults.defaultMultiModalFeedback,
      showFeedback: !PresetDefaults.defaultMultiModalFeedback,
      animationDuration: PresetDefaults.defaultAnimationDuration,
      backgroundColor: PresetDefaults.bottomBarBackgroundColor,
      selectedColorOpacity: PresetDefaults.bottomBarDefaultSelectedColorOpacity,
    ),

    "Checkbox": ComponentPreset(
      pressDelay: PresetDefaults.defaultPressDelayAphasia,
      enableHaptic: !PresetDefaults.defaultMultiModalFeedback,
      showFeedback: !PresetDefaults.defaultMultiModalFeedback,
      // color: defaultAphasiaColor,
    ),

    "Radio": ComponentPreset(
      pressDelay: PresetDefaults.defaultPressDelayAphasia,
      enableHaptic: !PresetDefaults.defaultMultiModalFeedback,
      showFeedback: !PresetDefaults.defaultMultiModalFeedback,
      // color: defaultAphasiaColor,
    ),

    "Slider": ComponentPreset(
      pressDelay: PresetDefaults.defaultPressDelayAphasia,
      enableHaptic: !PresetDefaults.defaultMultiModalFeedback,
      showFeedback: !PresetDefaults.defaultMultiModalFeedback,
      // activeColor: defaultAphasiaColor,
      inactiveColor: PresetDefaults.defaultInactiveColor,
    ),

    "Switch": ComponentPreset(
      pressDelay: PresetDefaults.defaultPressDelayAphasia,
      enableHaptic: !PresetDefaults.defaultMultiModalFeedback,
      showFeedback: !PresetDefaults.defaultMultiModalFeedback,
      // color: defaultAphasiaColor,
    ),

    "TextField": ComponentPreset(
      pressDelay: PresetDefaults.defaultPressDelayAphasia,
      enableHaptic: !PresetDefaults.defaultMultiModalFeedback,
      showFeedback: !PresetDefaults.defaultMultiModalFeedback,
      // color: defaultAphasiaColor,
    ),

    "Dropdown": ComponentPreset(
      pressDelay: PresetDefaults.defaultPressDelayAphasia,
      enableHaptic: !PresetDefaults.defaultMultiModalFeedback,
      showFeedback: !PresetDefaults.defaultMultiModalFeedback,
      // color: defaultAphasiaColor,
      listColor: PresetDefaults.buttonDefaultFontColor,
    ),

    "Time Picker": ComponentPreset(
      pressDelay: PresetDefaults.defaultPressDelayAphasia,
      enableHaptic: !PresetDefaults.defaultMultiModalFeedback,
      showFeedback: !PresetDefaults.defaultMultiModalFeedback,
      color: PresetDefaults.buttonDefaultFontColor,
      // fontColor: defaultAphasiaColor,
    ),
  });
}
