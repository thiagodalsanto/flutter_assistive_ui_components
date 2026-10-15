import 'package:flutter/material.dart';
import 'package:flutter_assistive_ui_components/src/helpers/preset_mapper.dart';
import 'package:flutter_assistive_ui_components/src/helpers/preset_size_multiplier.dart';
import 'package:flutter_assistive_ui_components/src/models/models.dart';
import 'package:flutter_assistive_ui_components/src/presets/base_values.dart';
import 'package:flutter_assistive_ui_components/src/providers/providers.dart';

void applySevereMotor(UserComponentProvider p) {
  const defaultSevereColor = Colors.deepOrange;

  applyPresetSizeMultiplier(p, 1.4);

  applyPresetMap(p, {
    "Action Menu": ComponentPreset(
      pressDelay: PresetDefaults.defaultPressDelaySevere,
      enableHaptic: !PresetDefaults.defaultMultiModalFeedback,
      showFeedback: !PresetDefaults.defaultMultiModalFeedback,
    ),
    "Button": ComponentPreset(
      // fontColor: PresetDefaults.buttonDefaultFontColor,
      pressDelay: PresetDefaults.defaultPressDelaySevere,
      showFeedback: !PresetDefaults.defaultMultiModalFeedback,
      enableHaptic: !PresetDefaults.defaultMultiModalFeedback,
      // color: defaultSevereColor,
    ),

    "Text Button": ComponentPreset(
      // fontColor: PresetDefaults.textButtonDefaultFontColor,
      pressDelay: PresetDefaults.defaultPressDelaySevere,
      showFeedback: !PresetDefaults.defaultMultiModalFeedback,
      enableHaptic: !PresetDefaults.defaultMultiModalFeedback,
    ),

    "Big Button": ComponentPreset(
      // fontColor: PresetDefaults.buttonDefaultFontColor,
      pressDelay: PresetDefaults.defaultPressDelaySevere,
      showFeedback: !PresetDefaults.defaultMultiModalFeedback,
      enableHaptic: !PresetDefaults.defaultMultiModalFeedback,
      // color: defaultSevereColor,
    ),

    "Icon Button": ComponentPreset(
      pressDelay: PresetDefaults.defaultPressDelaySevere,
      enableHaptic: !PresetDefaults.defaultMultiModalFeedback,
      showFeedback: !PresetDefaults.defaultMultiModalFeedback,
      iconColor: PresetDefaults.buttonDefaultFontColor,
      // color: defaultSevereColor,
    ),

    "Linear Progress": ComponentPreset(
      color: PresetDefaults.linearProgressDefaultColor,
      showLabel: PresetDefaults.linearProgressDefaultShowLabel,
      isAnimated: PresetDefaults.linearProgressDefaultIsAnimated,
      animationDuration: PresetDefaults.defaultAnimationDuration,
      borderColor: PresetDefaults.linearProgressDefaultBorderColor,
      // valueColor: defaultSevereColor,
      // labelColor: defaultSevereColor,
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
      pressDelay: PresetDefaults.defaultPressDelaySevere,
      enableHaptic: !PresetDefaults.defaultMultiModalFeedback,
      showFeedback: !PresetDefaults.defaultMultiModalFeedback,
      showIcon: !PresetDefaults.defaultMultiModalFeedback,
    ),

    "Bottom Bar": ComponentPreset(
      inactiveColor: PresetDefaults.defaultInactiveColor,
      pressDelay: PresetDefaults.defaultPressDelaySevere,
      enableHaptic: !PresetDefaults.defaultMultiModalFeedback,
      showFeedback: !PresetDefaults.defaultMultiModalFeedback,
      animationDuration: PresetDefaults.defaultAnimationDuration,
      backgroundColor: PresetDefaults.bottomBarBackgroundColor,
      selectedColorOpacity: PresetDefaults.bottomBarDefaultSelectedColorOpacity,
    ),

    "Checkbox": ComponentPreset(
      pressDelay: PresetDefaults.defaultPressDelaySevere,
      enableHaptic: !PresetDefaults.defaultMultiModalFeedback,
      showFeedback: !PresetDefaults.defaultMultiModalFeedback,
      // color: defaultSevereColor,
    ),

    "Radio": ComponentPreset(
      pressDelay: PresetDefaults.defaultPressDelaySevere,
      enableHaptic: !PresetDefaults.defaultMultiModalFeedback,
      showFeedback: !PresetDefaults.defaultMultiModalFeedback,
      // color: defaultSevereColor,
    ),

    "Slider": ComponentPreset(
      pressDelay: PresetDefaults.defaultPressDelaySevere,
      enableHaptic: !PresetDefaults.defaultMultiModalFeedback,
      showFeedback: !PresetDefaults.defaultMultiModalFeedback,
      // activeColor: defaultSevereColor,
      inactiveColor: PresetDefaults.defaultInactiveColor,
    ),

    "Switch": ComponentPreset(
      pressDelay: PresetDefaults.defaultPressDelaySevere,
      enableHaptic: !PresetDefaults.defaultMultiModalFeedback,
      showFeedback: !PresetDefaults.defaultMultiModalFeedback,
      // color: defaultSevereColor,
    ),

    "TextField": ComponentPreset(
      pressDelay: PresetDefaults.defaultPressDelaySevere,
      enableHaptic: !PresetDefaults.defaultMultiModalFeedback,
      showFeedback: !PresetDefaults.defaultMultiModalFeedback,
      // color: defaultSevereColor,
    ),

    "Dropdown": ComponentPreset(
      pressDelay: PresetDefaults.defaultPressDelaySevere,
      enableHaptic: !PresetDefaults.defaultMultiModalFeedback,
      showFeedback: !PresetDefaults.defaultMultiModalFeedback,
      // color: defaultSevereColor,
      listColor: PresetDefaults.buttonDefaultFontColor,
    ),

    "Time Picker": ComponentPreset(
      pressDelay: PresetDefaults.defaultPressDelaySevere,
      enableHaptic: !PresetDefaults.defaultMultiModalFeedback,
      showFeedback: !PresetDefaults.defaultMultiModalFeedback,
      color: PresetDefaults.buttonDefaultFontColor,
      // fontColor: defaultSevereColor,
    ),
  });
}
