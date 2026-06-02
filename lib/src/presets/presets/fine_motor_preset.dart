import 'package:flutter_assistive_ui_components/src/helpers/preset_mapper.dart';
import 'package:flutter_assistive_ui_components/src/presets/base_values.dart';

import 'package:flutter_assistive_ui_components/src/providers/providers.dart';
import 'package:flutter_assistive_ui_components/src/models/models.dart';
import 'package:flutter/material.dart';

void applyFineMotor(UserComponentProvider p) {
  const defaultFineColor = Colors.blue;

  applyPresetMap(p, {
    "Button": ComponentPreset(
      width: PresetDefaults.buttonDefaultWidth,
      height: PresetDefaults.buttonDefaultHeight,
      fontSize: PresetDefaults.buttonDefaultFontSize,
      touchPadding: PresetDefaults.defaultTouchPadding,
      padding: PresetDefaults.defaultPadding,
      fontColor: PresetDefaults.buttonDefaultFontColor,
      pressDelay: PresetDefaults.defaultPressDelay,
      showFeedback: PresetDefaults.defaultMultiModalFeedback,
      enableHaptic: PresetDefaults.defaultMultiModalFeedback,
      color: defaultFineColor,
    ),

    "Icon Button": ComponentPreset(
      pressDelay: PresetDefaults.defaultPressDelay,
      enableHaptic: PresetDefaults.defaultMultiModalFeedback,
      showFeedback: PresetDefaults.defaultMultiModalFeedback,
      padding: PresetDefaults.defaultPadding,
      touchPadding: PresetDefaults.defaultTouchPadding,
      width: PresetDefaults.iconButtonDefaultWidth,
      height: PresetDefaults.iconButtonDefaultHeight,
      iconSize: PresetDefaults.iconButtonDefaultIconSize,
      borderRadius: PresetDefaults.defaultBorderRadius,
      iconColor: PresetDefaults.buttonDefaultFontColor,
      color: defaultFineColor,
    ),

    "Linear Progress": ComponentPreset(
      width: PresetDefaults.linearProgressDefaultWidth,
      height: PresetDefaults.linearProgressDefaultHeight,
      borderRadius: PresetDefaults.defaultBorderRadius,
      color: PresetDefaults.linearProgressDefaultColor,
      showLabel: PresetDefaults.linearProgressDefaultShowLabel,
      isAnimated: PresetDefaults.linearProgressDefaultIsAnimated,
      animationDuration: PresetDefaults.defaultAnimationDuration,
      borderColor: PresetDefaults.linearProgressDefaultBorderColor,
      valueColor: defaultFineColor,
      labelColor: defaultFineColor,
    ),

    "Alert Dialog": ComponentPreset(
      enableHaptic: PresetDefaults.defaultMultiModalFeedback,
      showFeedback: PresetDefaults.defaultMultiModalFeedback,
      confirmBorderRadius: PresetDefaults.defaultBorderRadius,
      cancelBorderRadius: PresetDefaults.defaultBorderRadius,
      borderRadius: PresetDefaults.defaultBorderRadius,
      padding: PresetDefaults.defaultPadding,
      confirmWidth: PresetDefaults.alertDialogButtonWidth,
      confirmHeight: PresetDefaults.alertDialogButtonHeight,
      cancelWidth: PresetDefaults.alertDialogButtonWidth,
      cancelHeight: PresetDefaults.alertDialogButtonHeight,
      width: PresetDefaults.alertDialogWidth,
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
      height: PresetDefaults.tabBarDefaultHeight,
      padding: PresetDefaults.tabBarDefaultPadding,
    ),

    "Bottom Bar": ComponentPreset(
      inactiveColor: PresetDefaults.defaultInactiveColor,
      pressDelay: PresetDefaults.defaultPressDelay,
      enableHaptic: PresetDefaults.defaultMultiModalFeedback,
      showFeedback: PresetDefaults.defaultMultiModalFeedback,
      animationDuration: PresetDefaults.defaultAnimationDuration,
      backgroundColor: PresetDefaults.bottomBarBackgroundColor,
      itemPaddingHorizontal: PresetDefaults.bottomBarDefaultItemPaddingHorizontal,
      itemPaddingVertical: PresetDefaults.bottomBarDefaultItemPaddingVertical,
      margin: PresetDefaults.bottomBarDefaultMargin,
      selectedColorOpacity: PresetDefaults.bottomBarDefaultSelectedColorOpacity,
    ),

    "Checkbox": ComponentPreset(
      pressDelay: PresetDefaults.defaultPressDelay,
      enableHaptic: PresetDefaults.defaultMultiModalFeedback,
      showFeedback: PresetDefaults.defaultMultiModalFeedback,
      touchPadding: PresetDefaults.defaultTouchPadding,
      padding: PresetDefaults.defaultPadding,
      scale: PresetDefaults.checkboxDefaultScale,
      color: defaultFineColor,
    ),

    "Radio": ComponentPreset(
      pressDelay: PresetDefaults.defaultPressDelay,
      enableHaptic: PresetDefaults.defaultMultiModalFeedback,
      showFeedback: PresetDefaults.defaultMultiModalFeedback,
      touchPadding: PresetDefaults.defaultTouchPadding,
      padding: PresetDefaults.defaultPadding,
      color: defaultFineColor,
      size: PresetDefaults.radioDefaultSize,
    ),

    "Slider": ComponentPreset(
      pressDelay: PresetDefaults.defaultPressDelay,
      enableHaptic: PresetDefaults.defaultMultiModalFeedback,
      showFeedback: PresetDefaults.defaultMultiModalFeedback,
      padding: PresetDefaults.defaultPadding,
      touchPadding: PresetDefaults.defaultTouchPadding,
      height: PresetDefaults.textfieldDefaultHeight,
      width: PresetDefaults.textfieldDefaultWidth,
      activeColor: defaultFineColor,
      inactiveColor: PresetDefaults.defaultInactiveColor,
    ),

    "Switch": ComponentPreset(
      pressDelay: PresetDefaults.defaultPressDelay,
      enableHaptic: PresetDefaults.defaultMultiModalFeedback,
      showFeedback: PresetDefaults.defaultMultiModalFeedback,
      touchPadding: PresetDefaults.defaultTouchPadding,
      color: defaultFineColor,
      height: PresetDefaults.textfieldDefaultHeight,
      width: PresetDefaults.textfieldDefaultWidth,
    ),

    "TextField": ComponentPreset(
      pressDelay: PresetDefaults.defaultPressDelay,
      enableHaptic: PresetDefaults.defaultMultiModalFeedback,
      showFeedback: PresetDefaults.defaultMultiModalFeedback,
      touchPadding: PresetDefaults.defaultTouchPadding,
      padding: PresetDefaults.defaultPadding,
      color: defaultFineColor,
      height: PresetDefaults.textfieldDefaultHeight,
      width: PresetDefaults.textfieldDefaultWidth,
    ),

    "Dropdown": ComponentPreset(
      pressDelay: PresetDefaults.defaultPressDelay,
      enableHaptic: PresetDefaults.defaultMultiModalFeedback,
      showFeedback: PresetDefaults.defaultMultiModalFeedback,
      touchPadding: PresetDefaults.defaultTouchPadding,
      padding: PresetDefaults.defaultPadding,
      height: PresetDefaults.dropdownDefaultHeight,
      width: PresetDefaults.dropdownDefaultWidth,
      color: defaultFineColor,
      listColor: PresetDefaults.buttonDefaultFontColor,
    ),

    "Time Picker": ComponentPreset(
      pressDelay: PresetDefaults.defaultPressDelay,
      enableHaptic: PresetDefaults.defaultMultiModalFeedback,
      showFeedback: PresetDefaults.defaultMultiModalFeedback,
      touchPadding: PresetDefaults.defaultTouchPadding,
      padding: PresetDefaults.defaultPadding,
      height: PresetDefaults.timePickerDefaultHeight,
      width: PresetDefaults.timePickerDefaultWidth,
      fontSize: PresetDefaults.timePickerDefaultFontSize,
      color: PresetDefaults.buttonDefaultFontColor,
      fontColor: defaultFineColor,
    ),
  });
}
