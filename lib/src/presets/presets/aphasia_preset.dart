import 'package:flutter_assistive_ui_components/src/models/models.dart';
import 'package:flutter_assistive_ui_components/src/helpers/preset_mapper.dart';
import 'package:flutter_assistive_ui_components/src/presets/base_values.dart';
import 'package:flutter/material.dart';

import 'package:flutter_assistive_ui_components/src/providers/providers.dart';

void applyAphasia(UserComponentProvider p) {
  const defaultAphasiaColor = Colors.deepPurple;

  applyPresetMap(p, {
    "Button": ComponentPreset(
      width: PresetDefaults.buttonDefaultWidth * 1.2,
      height: PresetDefaults.buttonDefaultHeight * 1.2,
      fontSize: PresetDefaults.buttonDefaultFontSize,
      touchPadding: PresetDefaults.defaultTouchPadding * 1.2,
      padding: PresetDefaults.defaultPadding * 1.2,
      fontColor: PresetDefaults.buttonDefaultFontColor,
      pressDelay: PresetDefaults.defaultPressDelayAphasia,
      showFeedback: !PresetDefaults.defaultMultiModalFeedback,
      enableHaptic: !PresetDefaults.defaultMultiModalFeedback,
      color: defaultAphasiaColor,
    ),

    "Icon Button": ComponentPreset(
      pressDelay: PresetDefaults.defaultPressDelayAphasia,
      enableHaptic: !PresetDefaults.defaultMultiModalFeedback,
      showFeedback: !PresetDefaults.defaultMultiModalFeedback,
      padding: PresetDefaults.defaultPadding * 1.2,
      touchPadding: PresetDefaults.defaultTouchPadding * 1.2,
      width: PresetDefaults.iconButtonDefaultWidth * 1.2,
      height: PresetDefaults.iconButtonDefaultHeight * 1.2,
      iconSize: PresetDefaults.iconButtonDefaultIconSize * 1.2,
      borderRadius: PresetDefaults.defaultBorderRadius,
      iconColor: PresetDefaults.buttonDefaultFontColor,
      color: defaultAphasiaColor,
    ),

    "Linear Progress": ComponentPreset(
      width: PresetDefaults.linearProgressDefaultWidth * 1.2,
      height: PresetDefaults.linearProgressDefaultHeight * 1.2,
      borderRadius: PresetDefaults.defaultBorderRadius,
      color: PresetDefaults.linearProgressDefaultColor,
      showLabel: PresetDefaults.linearProgressDefaultShowLabel,
      isAnimated: PresetDefaults.linearProgressDefaultIsAnimated,
      animationDuration: PresetDefaults.defaultAnimationDuration,
      borderColor: PresetDefaults.linearProgressDefaultBorderColor,
      valueColor: defaultAphasiaColor,
      labelColor: defaultAphasiaColor,
    ),

    "Alert Dialog": ComponentPreset(
      enableHaptic: !PresetDefaults.defaultMultiModalFeedback,
      showFeedback: !PresetDefaults.defaultMultiModalFeedback,
      confirmBorderRadius: PresetDefaults.defaultBorderRadius,
      cancelBorderRadius: PresetDefaults.defaultBorderRadius,
      borderRadius: PresetDefaults.defaultBorderRadius,
      padding: PresetDefaults.defaultPadding * 1.2,
      confirmWidth: PresetDefaults.alertDialogButtonWidth * 1.2,
      confirmHeight: PresetDefaults.alertDialogButtonHeight * 1.2,
      cancelWidth: PresetDefaults.alertDialogButtonWidth * 1.2,
      cancelHeight: PresetDefaults.alertDialogButtonHeight * 1.2,
      width: PresetDefaults.alertDialogWidth * 1.2,
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
      height: PresetDefaults.tabBarDefaultHeight * 1.2,
      padding: PresetDefaults.tabBarDefaultPadding * 1.2,
    ),

    "Bottom Bar": ComponentPreset(
      inactiveColor: PresetDefaults.defaultInactiveColor,
      pressDelay: PresetDefaults.defaultPressDelayAphasia,
      enableHaptic: !PresetDefaults.defaultMultiModalFeedback,
      showFeedback: !PresetDefaults.defaultMultiModalFeedback,
      animationDuration: PresetDefaults.defaultAnimationDuration,
      backgroundColor: PresetDefaults.bottomBarBackgroundColor,
      itemPaddingHorizontal: PresetDefaults.bottomBarDefaultItemPaddingHorizontal * 1.2,
      itemPaddingVertical: PresetDefaults.bottomBarDefaultItemPaddingVertical * 1.2,
      margin: PresetDefaults.bottomBarDefaultMargin * 1.2,
      selectedColorOpacity: PresetDefaults.bottomBarDefaultSelectedColorOpacity,
    ),

    "Checkbox": ComponentPreset(
      pressDelay: PresetDefaults.defaultPressDelayAphasia,
      enableHaptic: !PresetDefaults.defaultMultiModalFeedback,
      showFeedback: !PresetDefaults.defaultMultiModalFeedback,
      touchPadding: PresetDefaults.defaultTouchPadding * 1.2,
      padding: PresetDefaults.defaultPadding * 1.2,
      scale: PresetDefaults.checkboxDefaultScale,
      color: defaultAphasiaColor,
    ),

    "Radio": ComponentPreset(
      pressDelay: PresetDefaults.defaultPressDelayAphasia,
      enableHaptic: !PresetDefaults.defaultMultiModalFeedback,
      showFeedback: !PresetDefaults.defaultMultiModalFeedback,
      touchPadding: PresetDefaults.defaultTouchPadding * 1.2,
      padding: PresetDefaults.defaultPadding * 1.2,
      color: defaultAphasiaColor,
      size: PresetDefaults.radioDefaultSize,
    ),

    "Slider": ComponentPreset(
      pressDelay: PresetDefaults.defaultPressDelayAphasia,
      enableHaptic: !PresetDefaults.defaultMultiModalFeedback,
      showFeedback: !PresetDefaults.defaultMultiModalFeedback,
      padding: PresetDefaults.defaultPadding * 1.2,
      touchPadding: PresetDefaults.defaultTouchPadding * 1.2,
      height: PresetDefaults.textfieldDefaultHeight * 1.2,
      width: PresetDefaults.textfieldDefaultWidth * 1.2,
      activeColor: defaultAphasiaColor,
      inactiveColor: PresetDefaults.defaultInactiveColor,
    ),

    "Switch": ComponentPreset(
      pressDelay: PresetDefaults.defaultPressDelayAphasia,
      enableHaptic: !PresetDefaults.defaultMultiModalFeedback,
      showFeedback: !PresetDefaults.defaultMultiModalFeedback,
      touchPadding: PresetDefaults.defaultTouchPadding * 1.2,
      color: defaultAphasiaColor,
      height: PresetDefaults.textfieldDefaultHeight * 1.2,
      width: PresetDefaults.textfieldDefaultWidth * 1.2,
    ),

    "TextField": ComponentPreset(
      pressDelay: PresetDefaults.defaultPressDelayAphasia,
      enableHaptic: !PresetDefaults.defaultMultiModalFeedback,
      showFeedback: !PresetDefaults.defaultMultiModalFeedback,
      touchPadding: PresetDefaults.defaultTouchPadding * 1.2,
      padding: PresetDefaults.defaultPadding * 1.2,
      color: defaultAphasiaColor,
      height: PresetDefaults.textfieldDefaultHeight * 1.2,
      width: PresetDefaults.textfieldDefaultWidth * 1.2,
    ),

    "Dropdown": ComponentPreset(
      pressDelay: PresetDefaults.defaultPressDelayAphasia,
      enableHaptic: !PresetDefaults.defaultMultiModalFeedback,
      showFeedback: !PresetDefaults.defaultMultiModalFeedback,
      touchPadding: PresetDefaults.defaultTouchPadding * 1.2,
      padding: PresetDefaults.defaultPadding * 1.2,
      height: PresetDefaults.dropdownDefaultHeight * 1.2,
      width: PresetDefaults.dropdownDefaultWidth * 1.2,
      color: defaultAphasiaColor,
      listColor: PresetDefaults.buttonDefaultFontColor,
    ),

    "Time Picker": ComponentPreset(
      pressDelay: PresetDefaults.defaultPressDelayAphasia,
      enableHaptic: !PresetDefaults.defaultMultiModalFeedback,
      showFeedback: !PresetDefaults.defaultMultiModalFeedback,
      touchPadding: PresetDefaults.defaultTouchPadding * 1.2,
      padding: PresetDefaults.defaultPadding * 1.2,
      height: PresetDefaults.timePickerDefaultHeight * 1.2,
      width: PresetDefaults.timePickerDefaultWidth * 1.2,
      fontSize: PresetDefaults.timePickerDefaultFontSize * 1.2,
      color: PresetDefaults.buttonDefaultFontColor,
      fontColor: defaultAphasiaColor,
    ),
  });
}
