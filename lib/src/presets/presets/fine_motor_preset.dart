import 'package:flutter/material.dart';
import 'package:flutter_assistive_ui_components/src/helpers/preset_mapper.dart';
import 'package:flutter_assistive_ui_components/src/helpers/preset_size_multiplier.dart';
import 'package:flutter_assistive_ui_components/src/models/models.dart';
import 'package:flutter_assistive_ui_components/src/presets/base_values.dart';
import 'package:flutter_assistive_ui_components/src/providers/providers.dart';

void applyFineMotor(UserComponentProvider p) {
  const defaultFineColor = Colors.blue;

  applyPresetSizeMultiplier(p, 1.0);

  applyPresetMap(p, {
    "Action Menu": ComponentPreset(
      pressDelay: PresetDefaults.defaultPressDelay,
      enableHaptic: PresetDefaults.defaultMultiModalFeedback,
      showFeedback: PresetDefaults.defaultMultiModalFeedback,
    ),
    "Button": ComponentPreset(
      // fontColor: PresetDefaults.buttonDefaultFontColor,
      pressDelay: PresetDefaults.defaultPressDelay,
      showFeedback: PresetDefaults.defaultMultiModalFeedback,
      enableHaptic: PresetDefaults.defaultMultiModalFeedback,
      // color: defaultFineColor,
    ),

    "Text Button": ComponentPreset(
      // fontColor: PresetDefaults.textButtonDefaultFontColor,
      pressDelay: PresetDefaults.defaultPressDelay,
      showFeedback: PresetDefaults.defaultMultiModalFeedback,
      enableHaptic: PresetDefaults.defaultMultiModalFeedback,
    ),

    "Big Button": ComponentPreset(
      // fontColor: PresetDefaults.buttonDefaultFontColor,
      pressDelay: PresetDefaults.defaultPressDelay,
      showFeedback: !PresetDefaults.defaultMultiModalFeedback,
      enableHaptic: !PresetDefaults.defaultMultiModalFeedback,
      // color: defaultFineColor,
    ),

    "Icon Button": ComponentPreset(
      pressDelay: PresetDefaults.defaultPressDelay,
      enableHaptic: PresetDefaults.defaultMultiModalFeedback,
      showFeedback: PresetDefaults.defaultMultiModalFeedback,
      iconColor: PresetDefaults.buttonDefaultFontColor,
      // color: defaultFineColor,
    ),

    "Linear Progress": ComponentPreset(
      color: PresetDefaults.linearProgressDefaultColor,
      showLabel: PresetDefaults.linearProgressDefaultShowLabel,
      isAnimated: PresetDefaults.linearProgressDefaultIsAnimated,
      animationDuration: PresetDefaults.defaultAnimationDuration,
      borderColor: PresetDefaults.linearProgressDefaultBorderColor,
      // valueColor: defaultFineColor,
      // labelColor: defaultFineColor,
    ),

    "Alert Dialog": ComponentPreset(
      enableHaptic: PresetDefaults.defaultMultiModalFeedback,
      showFeedback: PresetDefaults.defaultMultiModalFeedback,
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
      pressDelay: PresetDefaults.defaultPressDelay,
      enableHaptic: PresetDefaults.defaultMultiModalFeedback,
      showFeedback: PresetDefaults.defaultMultiModalFeedback,
      showIcon: PresetDefaults.defaultMultiModalFeedback,
    ),

    "Bottom Bar": ComponentPreset(
      inactiveColor: PresetDefaults.defaultInactiveColor,
      pressDelay: PresetDefaults.defaultPressDelay,
      enableHaptic: PresetDefaults.defaultMultiModalFeedback,
      showFeedback: PresetDefaults.defaultMultiModalFeedback,
      animationDuration: PresetDefaults.defaultAnimationDuration,
      backgroundColor: PresetDefaults.bottomBarBackgroundColor,
      selectedColorOpacity: PresetDefaults.bottomBarDefaultSelectedColorOpacity,
    ),

    "Checkbox": ComponentPreset(
      pressDelay: PresetDefaults.defaultPressDelay,
      enableHaptic: PresetDefaults.defaultMultiModalFeedback,
      showFeedback: PresetDefaults.defaultMultiModalFeedback,
      // color: defaultFineColor,
    ),

    "Radio": ComponentPreset(
      pressDelay: PresetDefaults.defaultPressDelay,
      enableHaptic: PresetDefaults.defaultMultiModalFeedback,
      showFeedback: PresetDefaults.defaultMultiModalFeedback,
      // color: defaultFineColor,
    ),

    "Slider": ComponentPreset(
      pressDelay: PresetDefaults.defaultPressDelay,
      enableHaptic: PresetDefaults.defaultMultiModalFeedback,
      showFeedback: PresetDefaults.defaultMultiModalFeedback,
      // activeColor: defaultFineColor,
      inactiveColor: PresetDefaults.defaultInactiveColor,
    ),

    "Switch": ComponentPreset(
      pressDelay: PresetDefaults.defaultPressDelay,
      enableHaptic: PresetDefaults.defaultMultiModalFeedback,
      showFeedback: PresetDefaults.defaultMultiModalFeedback,
      // color: defaultFineColor,
    ),

    "TextField": ComponentPreset(
      pressDelay: PresetDefaults.defaultPressDelay,
      enableHaptic: PresetDefaults.defaultMultiModalFeedback,
      showFeedback: PresetDefaults.defaultMultiModalFeedback,
      // color: defaultFineColor,
    ),

    "Dropdown": ComponentPreset(
      pressDelay: PresetDefaults.defaultPressDelay,
      enableHaptic: PresetDefaults.defaultMultiModalFeedback,
      showFeedback: PresetDefaults.defaultMultiModalFeedback,
      // color: defaultFineColor,
      listColor: PresetDefaults.buttonDefaultFontColor,
    ),

    "Time Picker": ComponentPreset(
      pressDelay: PresetDefaults.defaultPressDelay,
      enableHaptic: PresetDefaults.defaultMultiModalFeedback,
      showFeedback: PresetDefaults.defaultMultiModalFeedback,
      color: PresetDefaults.buttonDefaultFontColor,
      // fontColor: defaultFineColor,
    ),
  });
}
