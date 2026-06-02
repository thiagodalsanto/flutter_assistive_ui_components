import 'package:flutter_assistive_ui_components/src/helpers/preset_mapper.dart';
import 'package:flutter_assistive_ui_components/src/presets/base_values.dart';
import 'package:flutter_assistive_ui_components/src/providers/providers.dart';
import 'package:flutter_assistive_ui_components/src/models/models.dart';
import 'package:flutter/material.dart';

void applySevereMotor(UserComponentProvider p) {
  const defaultSevereColor = Colors.deepOrange;

  applyPresetMap(p, {
    "Button": ComponentPreset(
      width: PresetDefaults.buttonDefaultWidth * 1.4,
      height: PresetDefaults.buttonDefaultHeight * 1.4,
      fontSize: PresetDefaults.buttonDefaultFontSize,
      touchPadding: PresetDefaults.defaultTouchPadding * 1.4,
      padding: PresetDefaults.defaultPadding * 1.4,
      fontColor: PresetDefaults.buttonDefaultFontColor,
      pressDelay: PresetDefaults.defaultPressDelaySevere,
      showFeedback: !PresetDefaults.defaultMultiModalFeedback,
      enableHaptic: !PresetDefaults.defaultMultiModalFeedback,
      color: defaultSevereColor,
    ),

    "Icon Button": ComponentPreset(
      pressDelay: PresetDefaults.defaultPressDelaySevere,
      enableHaptic: !PresetDefaults.defaultMultiModalFeedback,
      showFeedback: !PresetDefaults.defaultMultiModalFeedback,
      padding: PresetDefaults.defaultPadding * 1.4,
      touchPadding: PresetDefaults.defaultTouchPadding * 1.4,
      width: PresetDefaults.iconButtonDefaultWidth * 1.4,
      height: PresetDefaults.iconButtonDefaultHeight * 1.4,
      iconSize: PresetDefaults.iconButtonDefaultIconSize * 1.4,
      borderRadius: PresetDefaults.defaultBorderRadius,
      iconColor: PresetDefaults.buttonDefaultFontColor,
      color: defaultSevereColor,
    ),

    "Linear Progress": ComponentPreset(
      width: PresetDefaults.linearProgressDefaultWidth * 1.4,
      height: PresetDefaults.linearProgressDefaultHeight * 1.4,
      borderRadius: PresetDefaults.defaultBorderRadius,
      color: PresetDefaults.linearProgressDefaultColor,
      showLabel: PresetDefaults.linearProgressDefaultShowLabel,
      isAnimated: PresetDefaults.linearProgressDefaultIsAnimated,
      animationDuration: PresetDefaults.defaultAnimationDuration,
      borderColor: PresetDefaults.linearProgressDefaultBorderColor,
      valueColor: defaultSevereColor,
      labelColor: defaultSevereColor,
    ),

    "Alert Dialog": ComponentPreset(
      enableHaptic: !PresetDefaults.defaultMultiModalFeedback,
      showFeedback: !PresetDefaults.defaultMultiModalFeedback,
      confirmBorderRadius: PresetDefaults.defaultBorderRadius,
      cancelBorderRadius: PresetDefaults.defaultBorderRadius,
      borderRadius: PresetDefaults.defaultBorderRadius,
      padding: PresetDefaults.defaultPadding * 1.4,
      confirmWidth: PresetDefaults.alertDialogButtonWidth * 1.4,
      confirmHeight: PresetDefaults.alertDialogButtonHeight * 1.4,
      cancelWidth: PresetDefaults.alertDialogButtonWidth * 1.4,
      cancelHeight: PresetDefaults.alertDialogButtonHeight * 1.4,
      width: PresetDefaults.alertDialogWidth * 1.4,
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
      height: PresetDefaults.tabBarDefaultHeight * 1.4,
      padding: PresetDefaults.tabBarDefaultPadding * 1.4,
    ),

    "Bottom Bar": ComponentPreset(
      inactiveColor: PresetDefaults.defaultInactiveColor,
      pressDelay: PresetDefaults.defaultPressDelaySevere,
      enableHaptic: !PresetDefaults.defaultMultiModalFeedback,
      showFeedback: !PresetDefaults.defaultMultiModalFeedback,
      animationDuration: PresetDefaults.defaultAnimationDuration,
      backgroundColor: PresetDefaults.bottomBarBackgroundColor,
      itemPaddingHorizontal: PresetDefaults.bottomBarDefaultItemPaddingHorizontal * 1.4,
      itemPaddingVertical: PresetDefaults.bottomBarDefaultItemPaddingVertical * 1.4,
      margin: PresetDefaults.bottomBarDefaultMargin * 1.4,
      selectedColorOpacity: PresetDefaults.bottomBarDefaultSelectedColorOpacity,
    ),

    "Checkbox": ComponentPreset(
      pressDelay: PresetDefaults.defaultPressDelaySevere,
      enableHaptic: !PresetDefaults.defaultMultiModalFeedback,
      showFeedback: !PresetDefaults.defaultMultiModalFeedback,
      touchPadding: PresetDefaults.defaultTouchPadding * 1.4,
      padding: PresetDefaults.defaultPadding * 1.4,
      scale: PresetDefaults.checkboxDefaultScale,
      color: defaultSevereColor,
    ),

    "Radio": ComponentPreset(
      pressDelay: PresetDefaults.defaultPressDelaySevere,
      enableHaptic: !PresetDefaults.defaultMultiModalFeedback,
      showFeedback: !PresetDefaults.defaultMultiModalFeedback,
      touchPadding: PresetDefaults.defaultTouchPadding * 1.4,
      padding: PresetDefaults.defaultPadding * 1.4,
      color: defaultSevereColor,
      size: PresetDefaults.radioDefaultSize,
    ),

    "Slider": ComponentPreset(
      pressDelay: PresetDefaults.defaultPressDelaySevere,
      enableHaptic: !PresetDefaults.defaultMultiModalFeedback,
      showFeedback: !PresetDefaults.defaultMultiModalFeedback,
      padding: PresetDefaults.defaultPadding * 1.4,
      touchPadding: PresetDefaults.defaultTouchPadding * 1.4,
      height: PresetDefaults.textfieldDefaultHeight * 1.4,
      width: PresetDefaults.textfieldDefaultWidth * 1.4,
      activeColor: defaultSevereColor,
      inactiveColor: PresetDefaults.defaultInactiveColor,
    ),

    "Switch": ComponentPreset(
      pressDelay: PresetDefaults.defaultPressDelaySevere,
      enableHaptic: !PresetDefaults.defaultMultiModalFeedback,
      showFeedback: !PresetDefaults.defaultMultiModalFeedback,
      touchPadding: PresetDefaults.defaultTouchPadding * 1.4,
      color: defaultSevereColor,
      height: PresetDefaults.textfieldDefaultHeight * 1.4,
      width: PresetDefaults.textfieldDefaultWidth * 1.4,
    ),

    "TextField": ComponentPreset(
      pressDelay: PresetDefaults.defaultPressDelaySevere,
      enableHaptic: !PresetDefaults.defaultMultiModalFeedback,
      showFeedback: !PresetDefaults.defaultMultiModalFeedback,
      touchPadding: PresetDefaults.defaultTouchPadding * 1.4,
      padding: PresetDefaults.defaultPadding * 1.4,
      color: defaultSevereColor,
      height: PresetDefaults.textfieldDefaultHeight * 1.4,
      width: PresetDefaults.textfieldDefaultWidth * 1.4,
    ),

    "Dropdown": ComponentPreset(
      pressDelay: PresetDefaults.defaultPressDelaySevere,
      enableHaptic: !PresetDefaults.defaultMultiModalFeedback,
      showFeedback: !PresetDefaults.defaultMultiModalFeedback,
      touchPadding: PresetDefaults.defaultTouchPadding * 1.4,
      padding: PresetDefaults.defaultPadding * 1.4,
      height: PresetDefaults.dropdownDefaultHeight * 1.4,
      width: PresetDefaults.dropdownDefaultWidth * 1.4,
      color: defaultSevereColor,
      listColor: PresetDefaults.buttonDefaultFontColor,
    ),

    "Time Picker": ComponentPreset(
      pressDelay: PresetDefaults.defaultPressDelaySevere,
      enableHaptic: !PresetDefaults.defaultMultiModalFeedback,
      showFeedback: !PresetDefaults.defaultMultiModalFeedback,
      touchPadding: PresetDefaults.defaultTouchPadding * 1.4,
      padding: PresetDefaults.defaultPadding * 1.4,
      height: PresetDefaults.timePickerDefaultHeight * 1.4,
      width: PresetDefaults.timePickerDefaultWidth * 1.4,
      fontSize: PresetDefaults.timePickerDefaultFontSize * 1.4,
      color: PresetDefaults.buttonDefaultFontColor,
      fontColor: defaultSevereColor,
    ),
  });
}
