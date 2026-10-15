// ignore_for_file: deprecated_member_use

import 'package:flutter_assistive_ui_components/src/internal/assistive_button/manual_config_sheet/config_color_row.dart';
import 'package:flutter_assistive_ui_components/src/internal/assistive_button/manual_config_sheet/config_save_button.dart';
import 'package:flutter_assistive_ui_components/src/internal/assistive_button/manual_config_sheet/config_section.dart';
import 'package:flutter_assistive_ui_components/src/internal/assistive_button/manual_config_sheet/config_slider_row.dart';
import 'package:flutter_assistive_ui_components/src/internal/assistive_button/manual_config_sheet/config_switch_row.dart';
import 'package:flutter_assistive_ui_components/src/helpers/preset_size_multiplier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_assistive_ui_components/src/providers/providers.dart';
import 'package:flutter_assistive_ui_components/src/internal/assistive_text_pt.dart';

class ComponentConfigSheet extends StatefulWidget {
  final String component;

  const ComponentConfigSheet({super.key, required this.component});

  @override
  State<ComponentConfigSheet> createState() => _ComponentConfigSheetState();
}

class _ComponentConfigSheetState extends State<ComponentConfigSheet> {
  late String prefix;

  double linearProgressHeight = 12;
  double linearProgressWidth = 200;
  double linearProgressBorderRadius = 8;
  double linearProgressAnimationDuration = 300;
  Color linearProgressValueColor = Colors.blue;
  Color linearProgressColor = Colors.grey;
  Color linearProgressBorder = Colors.black;
  Color linearProgressLabelColor = Colors.black;
  bool linearProgressShowLabel = true;
  bool linearProgressAnimated = true;

  Color alertDialogTitleColor = Colors.black;
  Color alertDialogContentColor = Colors.black87;
  Color alertDialogBackgroundColor = Colors.white;
  bool alertDialogEnableHaptic = true;
  bool alertDialogShowFeedback = true;
  double alertDialogWidth = 300;
  double alertDialogPadding = 16;
  double alertDialogBorderRadius = 16;
  Duration alertDialogPressDelay = Duration.zero;
  double alertDialogConfirmWidth = 110;
  double alertDialogConfirmHeight = 40;
  double alertDialogConfirmBorderRadius = 8;
  Color alertDialogConfirmBackgroundColor = Colors.blue;
  Color alertDialogConfirmTextColor = Colors.white;
  double alertDialogCancelWidth = 110;
  double alertDialogCancelHeight = 40;
  double alertDialogCancelBorderRadius = 8;
  Color alertDialogCancelBackgroundColor = Colors.grey;
  Color alertDialogCancelTextColor = Colors.white;

  double tabBarHeight = 64;
  double tabBarPadding = 8;
  Color tabBarBackgroundColor = Colors.white;
  bool tabBarEnableHaptic = true;
  bool tabBarShowIcon = true;
  bool tabBarShowFeedback = true;
  double tabBarPressDelay = 0;

  double buttonWidth = 200;
  double buttonHeight = 50;
  double buttonFontSize = 16;
  double buttonTouchPadding = 12;
  double buttonPadding = 8;
  Color buttonColor = Colors.blue;
  Color buttonFontColor = Colors.white;
  bool buttonEnableHaptic = true;
  bool buttonShowFeedback = true;
  double buttonPressDelayMs = 0;
  bool buttonIconEnabled = true;

  double bigButtonWidth = 200;
  double bigButtonHeight = 80;
  double bigButtonFontSize = 16;
  double bigButtonTouchPadding = 12;
  double bigButtonPadding = 8;
  Color bigButtonColor = Colors.blue;
  Color bigButtonFontColor = Colors.white;
  bool bigButtonEnableHaptic = true;
  bool bigButtonShowFeedback = true;
  double bigButtonPressDelayMs = 0;
  bool bigButtonIconEnabled = true;

  double textButtonWidth = 200;
  double textButtonHeight = 50;
  double textButtonFontSize = 16;
  double textButtonTouchPadding = 12;
  double textButtonPadding = 8;
  Color textButtonColor = Colors.blue;
  Color textButtonFontColor = Colors.white;
  bool textButtonEnableHaptic = true;
  bool textButtonShowFeedback = true;
  double textButtonPressDelayMs = 0;
  bool textButtonIconEnabled = true;

  double iconButtonWidth = 200;
  double iconButtonHeight = 50;
  double iconButtonIconSize = 24;
  double iconButtonTouchPadding = 12;
  double iconButtonPadding = 8;
  Color iconButtonIconColor = Colors.white;
  Color iconButtonColor = Colors.blue;
  double iconButtonPressDelay = 0;
  Duration iconButtonHapticDuration = Duration.zero;
  bool iconButtonEnableHaptic = true;
  bool iconButtonShowFeedback = true;
  double iconButtonBorderRadius = 8;

  double timePickerWidth = 200;
  double timePickerHeight = 56;
  double timePickerTouchPadding = 12;
  double timePickerPadding = 8;
  double timePickerFontSize = 16;
  Color timePickerColor = Colors.blue;
  Color timePickerFontColor = Colors.white;
  bool timePickerEnableHaptic = true;
  bool timePickerShowFeedback = true;
  double timePickerPressDelay = 0;

  double bottomBarItemPaddingVertical = 16;
  double bottomBarItemPaddingHorizontal = 12;
  double bottomBarMargin = 0;
  double bottomBarPressDelay = 0;
  double bottomBarOpacity = 0.2;
  Color bottomBarBackgroundColor = Colors.white;
  Color bottomBarInactiveColor = Colors.grey;
  bool bottomBarEnableHaptic = true;
  bool bottomBarShowFeedback = true;

  double checkboxScale = 1.4;
  double checkboxPadding = 8;
  double checkboxTouchPadding = 16;
  double checkboxPressDelay = 300;
  Color checkboxColor = Colors.blue;
  bool checkboxEnableHaptic = true;
  bool checkboxShowFeedback = true;

  double radioSize = 8;
  double radioTouchPadding = 16;
  double radioPadding = 8;
  double radioPressDelay = 300;
  Color radioColor = Colors.blue;
  bool radioEnableHaptic = true;
  bool radioShowFeedback = true;

  double sliderWidth = 300;
  double sliderHeight = 8;
  double sliderPadding = 8;
  double sliderTouchPadding = 16;
  double sliderPressDelay = 300;
  Color sliderActiveColor = Colors.blue;
  Color sliderInactiveColor = Colors.grey;
  bool sliderEnableHaptic = true;
  bool sliderShowFeedback = true;

  double switchWidth = 72;
  double switchHeight = 40;
  double switchTouchPadding = 16;
  double switchPressDelay = 0;
  Color switchColor = Colors.blue;
  bool switchEnableHaptic = true;
  bool switchShowFeedback = true;

  double textfieldWidth = 200;
  double textfieldHeight = 56;
  double textfieldTouchPadding = 12;
  double textfieldPadding = 8;
  double textfieldPressDelay = 0;
  Color textfieldColor = Colors.blue;
  bool textfieldEnableHaptic = true;
  bool textfieldShowFeedback = true;

  double dropdownWidth = 200;
  double dropdownHeight = 56;
  double dropdownTouchPadding = 8;
  double dropdownPadding = 0;
  double dropdownPressDelay = 0;
  Color dropdownColor = Colors.blue;
  Color dropdownListColor = Colors.white;
  bool dropdownEnableHaptic = true;
  bool dropdownShowFeedback = true;

  double overviewCardHeight = 100;
  double overviewCardTouchPadding = 4;
  Color overviewCardColor = Colors.white;
  Color overviewCardSurfaceTintColor = Colors.black;
  bool overviewCardEnableHaptic = true;
  bool overviewCardShowFeedback = true;
  double overviewCardPressDelay = 0;

  String overviewCardFeedbackText = "Cartão pressionado";
  late TextEditingController overviewCardFeedbackController;

  double taskCardPadding = 16;
  double taskCardActionBarHeight = 48;
  Color taskCardBackgroundColor = Colors.white;
  Color taskCardActionBarColor = Colors.white;

  double sideMenuWidth = 304;
  Color sideMenuBackgroundColor = Colors.white;

  String _prefix(String c) => c.toLowerCase().replaceAll(" ", "");

  @override
  void initState() {
    super.initState();

    prefix = _prefix(widget.component);
    const String timePrefix = "timepicker";
    const String buttonPrefix = "button";
    const String bigButtonPrefix = "bigbutton";
    const String textButtonPrefix = "textbutton";
    const String iconButtonPrefix = "iconbutton";
    const String tabPrefix = "tabbar";
    const String alertPrefix = "alertdialog";
    const String bottomPrefix = "bottombar";
    const String checkboxPrefix = "checkbox";
    const String radioPrefix = "radio";
    const String sliderPrefix = "slider";
    const String switchPrefix = "switch";
    const String textfieldPrefix = "textfield";
    const String linearProgressPrefix = "linearprogress";
    const String dropdownPrefix = "dropdown";
    const String overviewCardPrefix = "overviewcard";
    const String taskCardPrefix = "taskcard";
    final p = Provider.of<UserComponentProvider>(context, listen: false);
    p.activeConfigComponent = widget.component.toLowerCase().replaceAll(" ", "");

    linearProgressHeight = p.getConfig("${linearProgressPrefix}_height") ?? linearProgressHeight;
    linearProgressWidth = p.getConfig("${linearProgressPrefix}_width") ?? linearProgressWidth;
    linearProgressBorderRadius =
        p.getConfig("${linearProgressPrefix}_borderRadius") ?? linearProgressBorderRadius;
    linearProgressAnimationDuration =
        p.getConfig("${linearProgressPrefix}_animationDuration") ?? linearProgressAnimationDuration;
    linearProgressValueColor =
        p.getConfig("${linearProgressPrefix}_valueColor") ?? linearProgressValueColor;
    linearProgressColor = p.getConfig("${linearProgressPrefix}_color") ?? linearProgressColor;
    linearProgressShowLabel =
        p.getConfig("${linearProgressPrefix}_showLabel") ?? linearProgressShowLabel;
    linearProgressAnimated = p.getConfig("${linearProgressPrefix}_animated") ?? linearProgressAnimated;
    linearProgressBorder = p.getConfig("${linearProgressPrefix}_borderColor") ?? linearProgressBorder;
    linearProgressLabelColor =
        p.getConfig("${linearProgressPrefix}_labelColor") ?? linearProgressLabelColor;

    buttonWidth = p.getConfig("${buttonPrefix}_width") ?? buttonWidth;
    buttonHeight = p.getConfig("${buttonPrefix}_height") ?? buttonHeight;
    buttonFontSize = p.getConfig("${buttonPrefix}_fontSize") ?? buttonFontSize;
    buttonTouchPadding = p.getConfig("${buttonPrefix}_touchPadding") ?? buttonTouchPadding;
    buttonPadding = p.getConfig("${buttonPrefix}_padding") ?? buttonPadding;
    buttonColor = p.getConfig("${buttonPrefix}_color") ?? buttonColor;
    buttonFontColor = p.getConfig("${buttonPrefix}_fontColor") ?? buttonFontColor;
    buttonEnableHaptic = p.getConfig("${buttonPrefix}_enableHaptic") ?? buttonEnableHaptic;
    buttonShowFeedback = p.getConfig("${buttonPrefix}_showFeedback") ?? buttonShowFeedback;
    buttonPressDelayMs = p.getConfig("${buttonPrefix}_pressDelay") ?? buttonPressDelayMs;
    buttonIconEnabled = p.getConfig("${buttonPrefix}_iconEnabled") ?? buttonIconEnabled;

    bigButtonWidth = p.getConfig("${bigButtonPrefix}_width") ?? bigButtonWidth;
    bigButtonHeight = p.getConfig("${bigButtonPrefix}_height") ?? bigButtonHeight;
    bigButtonFontSize = p.getConfig("${bigButtonPrefix}_fontSize") ?? bigButtonFontSize;
    bigButtonTouchPadding = p.getConfig("${bigButtonPrefix}_touchPadding") ?? bigButtonTouchPadding;
    bigButtonPadding = p.getConfig("${bigButtonPrefix}_padding") ?? bigButtonPadding;
    bigButtonColor = p.getConfig("${bigButtonPrefix}_color") ?? bigButtonColor;
    bigButtonFontColor = p.getConfig("${bigButtonPrefix}_fontColor") ?? bigButtonFontColor;
    bigButtonEnableHaptic = p.getConfig("${bigButtonPrefix}_enableHaptic") ?? bigButtonEnableHaptic;
    bigButtonShowFeedback = p.getConfig("${bigButtonPrefix}_showFeedback") ?? bigButtonShowFeedback;
    bigButtonPressDelayMs = p.getConfig("${bigButtonPrefix}_pressDelay") ?? bigButtonPressDelayMs;
    bigButtonIconEnabled = p.getConfig("${bigButtonPrefix}_iconEnabled") ?? bigButtonIconEnabled;

    textButtonWidth = p.getConfig("${textButtonPrefix}_width") ?? textButtonWidth;
    textButtonHeight = p.getConfig("${textButtonPrefix}_height") ?? textButtonHeight;
    textButtonFontSize = p.getConfig("${textButtonPrefix}_fontSize") ?? textButtonFontSize;
    textButtonTouchPadding = p.getConfig("${textButtonPrefix}_touchPadding") ?? textButtonTouchPadding;
    textButtonPadding = p.getConfig("${textButtonPrefix}_padding") ?? textButtonPadding;
    textButtonColor = p.getConfig("${textButtonPrefix}_color") ?? textButtonColor;
    textButtonFontColor = p.getConfig("${textButtonPrefix}_fontColor") ?? textButtonFontColor;
    textButtonEnableHaptic = p.getConfig("${textButtonPrefix}_enableHaptic") ?? textButtonEnableHaptic;
    textButtonShowFeedback = p.getConfig("${textButtonPrefix}_showFeedback") ?? textButtonShowFeedback;
    textButtonPressDelayMs = p.getConfig("${textButtonPrefix}_pressDelay") ?? textButtonPressDelayMs;
    textButtonIconEnabled = p.getConfig("${textButtonPrefix}_iconEnabled") ?? textButtonIconEnabled;

    iconButtonWidth = p.getConfig("${iconButtonPrefix}_width") ?? iconButtonWidth;
    iconButtonHeight = p.getConfig("${iconButtonPrefix}_height") ?? iconButtonHeight;
    iconButtonIconSize = p.getConfig("${iconButtonPrefix}_iconSize") ?? iconButtonIconSize;
    iconButtonTouchPadding = p.getConfig("${iconButtonPrefix}_touchPadding") ?? iconButtonTouchPadding;
    iconButtonPadding = p.getConfig("${iconButtonPrefix}_padding") ?? iconButtonPadding;
    iconButtonPressDelay = p.getConfig("${iconButtonPrefix}_pressDelay") ?? iconButtonPressDelay;
    iconButtonBorderRadius = p.getConfig("${iconButtonPrefix}_borderRadius") ?? iconButtonBorderRadius;
    iconButtonEnableHaptic = p.getConfig("${iconButtonPrefix}_enableHaptic") ?? iconButtonEnableHaptic;
    iconButtonShowFeedback = p.getConfig("${iconButtonPrefix}_showFeedback") ?? iconButtonShowFeedback;
    iconButtonIconColor = p.getConfig("${iconButtonPrefix}_iconColor") ?? iconButtonIconColor;
    iconButtonColor = p.getConfig("${iconButtonPrefix}_color") ?? iconButtonColor;

    timePickerWidth = p.getConfig("${timePrefix}_width") ?? timePickerWidth;
    timePickerHeight = p.getConfig("${timePrefix}_height") ?? timePickerHeight;
    timePickerTouchPadding = p.getConfig("${timePrefix}_touchPadding") ?? timePickerTouchPadding;
    timePickerFontSize = p.getConfig("${timePrefix}_fontSize") ?? timePickerFontSize;
    timePickerPadding = p.getConfig("${timePrefix}_padding") ?? timePickerPadding;
    timePickerColor = p.getConfig("${timePrefix}_color") ?? timePickerColor;
    timePickerFontColor = p.getConfig("${timePrefix}_fontColor") ?? timePickerFontColor;
    timePickerEnableHaptic = p.getConfig("${timePrefix}_enableHaptic") ?? timePickerEnableHaptic;
    timePickerShowFeedback = p.getConfig("${timePrefix}_showFeedback") ?? timePickerShowFeedback;
    timePickerPressDelay = p.getConfig("${timePrefix}_pressDelay") ?? timePickerPressDelay;

    tabBarHeight = p.getConfig("${tabPrefix}_height") ?? tabBarHeight;
    tabBarPadding = p.getConfig("${tabPrefix}_padding") ?? tabBarPadding;
    tabBarBackgroundColor = p.getConfig("${tabPrefix}_backgroundColor") ?? tabBarBackgroundColor;
    tabBarEnableHaptic = p.getConfig("${tabPrefix}_enableHaptic") ?? tabBarEnableHaptic;
    tabBarShowFeedback = p.getConfig("${tabPrefix}_showFeedback") ?? tabBarShowFeedback;
    tabBarShowIcon = p.getConfig("${tabPrefix}_showIcon") ?? tabBarShowIcon;
    tabBarShowFeedback = p.getConfig("${tabPrefix}_showFeedback") ?? tabBarShowFeedback;
    tabBarPressDelay = p.getConfig("${tabPrefix}_pressDelay") ?? tabBarPressDelay;

    alertDialogTitleColor = p.getConfig("${alertPrefix}_titleColor") ?? alertDialogTitleColor;
    alertDialogContentColor = p.getConfig("${alertPrefix}_contentColor") ?? alertDialogContentColor;
    alertDialogBackgroundColor =
        p.getConfig("${alertPrefix}_backgroundColor") ?? alertDialogBackgroundColor;
    alertDialogEnableHaptic = p.getConfig("${alertPrefix}_enableHaptic") ?? alertDialogEnableHaptic;
    alertDialogShowFeedback = p.getConfig("${alertPrefix}_showFeedback") ?? alertDialogShowFeedback;
    alertDialogWidth = p.getConfig("${alertPrefix}_width") ?? alertDialogWidth;
    alertDialogPadding = p.getConfig("${alertPrefix}_padding") ?? alertDialogPadding;
    alertDialogBorderRadius = p.getConfig("${alertPrefix}_borderRadius") ?? alertDialogBorderRadius;
    alertDialogConfirmWidth = p.getConfig("${alertPrefix}_confirmWidth") ?? alertDialogConfirmWidth;
    alertDialogConfirmHeight = p.getConfig("${alertPrefix}_confirmHeight") ?? alertDialogConfirmHeight;
    alertDialogConfirmBorderRadius =
        p.getConfig("${alertPrefix}_confirmBorderRadius") ?? alertDialogConfirmBorderRadius;
    alertDialogConfirmBackgroundColor =
        p.getConfig("${alertPrefix}_confirmBackgroundColor") ?? alertDialogConfirmBackgroundColor;
    alertDialogConfirmTextColor =
        p.getConfig("${alertPrefix}_confirmTextColor") ?? alertDialogConfirmTextColor;
    alertDialogCancelWidth = p.getConfig("${alertPrefix}_cancelWidth") ?? alertDialogCancelWidth;
    alertDialogCancelHeight = p.getConfig("${alertPrefix}_cancelHeight") ?? alertDialogCancelHeight;
    alertDialogCancelBorderRadius =
        p.getConfig("${alertPrefix}_cancelBorderRadius") ?? alertDialogCancelBorderRadius;
    alertDialogCancelBackgroundColor =
        p.getConfig("${alertPrefix}_cancelBackgroundColor") ?? alertDialogCancelBackgroundColor;
    alertDialogCancelTextColor =
        p.getConfig("${alertPrefix}_cancelTextColor") ?? alertDialogCancelTextColor;

    bottomBarItemPaddingVertical =
        p.getConfig("${bottomPrefix}_itemPaddingVertical") ?? bottomBarItemPaddingVertical;
    bottomBarItemPaddingHorizontal =
        p.getConfig("${bottomPrefix}_itemPaddingHorizontal") ?? bottomBarItemPaddingHorizontal;
    bottomBarMargin = p.getConfig("${bottomPrefix}_margin") ?? bottomBarMargin;
    bottomBarPressDelay = p.getConfig("${bottomPrefix}_pressDelay") ?? bottomBarPressDelay;
    bottomBarOpacity = p.getConfig("${bottomPrefix}_opacity") ?? bottomBarOpacity;
    bottomBarBackgroundColor =
        p.getConfig("${bottomPrefix}_backgroundColor") ?? bottomBarBackgroundColor;
    bottomBarInactiveColor = p.getConfig("${bottomPrefix}_inactiveColor") ?? bottomBarInactiveColor;
    bottomBarEnableHaptic = p.getConfig("${bottomPrefix}_enableHaptic") ?? bottomBarEnableHaptic;
    bottomBarShowFeedback = p.getConfig("${bottomPrefix}_showFeedback") ?? bottomBarShowFeedback;

    checkboxScale = p.getConfig("${checkboxPrefix}_scale") ?? checkboxScale;
    checkboxPadding = p.getConfig("${checkboxPrefix}_padding") ?? checkboxPadding;
    checkboxTouchPadding = p.getConfig("${checkboxPrefix}_touchPadding") ?? checkboxTouchPadding;
    checkboxColor = p.getConfig("${checkboxPrefix}_color") ?? checkboxColor;
    checkboxEnableHaptic = p.getConfig("${checkboxPrefix}_enableHaptic") ?? checkboxEnableHaptic;
    checkboxShowFeedback = p.getConfig("${checkboxPrefix}_showFeedback") ?? checkboxShowFeedback;
    checkboxPressDelay = p.getConfig("${checkboxPrefix}_pressDelay") ?? checkboxPressDelay;

    radioSize = p.getConfig("${radioPrefix}_size") ?? radioSize;
    radioTouchPadding = p.getConfig("${radioPrefix}_touchPadding") ?? radioTouchPadding;
    radioPadding = p.getConfig("${radioPrefix}_padding") ?? radioPadding;
    radioColor = p.getConfig("${radioPrefix}_color") ?? radioColor;
    radioEnableHaptic = p.getConfig("${radioPrefix}_enableHaptic") ?? radioEnableHaptic;
    radioShowFeedback = p.getConfig("${radioPrefix}_showFeedback") ?? radioShowFeedback;
    radioPressDelay = p.getConfig("${radioPrefix}_pressDelay") ?? radioPressDelay;

    sliderWidth = p.getConfig("${sliderPrefix}_width") ?? sliderWidth;
    sliderHeight = p.getConfig("${sliderPrefix}_height") ?? sliderHeight;
    sliderTouchPadding = p.getConfig("${sliderPrefix}_touchPadding") ?? sliderTouchPadding;
    sliderPadding = p.getConfig("${sliderPrefix}_padding") ?? sliderPadding;
    sliderInactiveColor = p.getConfig("${sliderPrefix}_inactiveColor") ?? sliderInactiveColor;
    sliderActiveColor = p.getConfig("${sliderPrefix}_activeColor") ?? sliderActiveColor;
    sliderEnableHaptic = p.getConfig("${sliderPrefix}_enableHaptic") ?? sliderEnableHaptic;
    sliderShowFeedback = p.getConfig("${sliderPrefix}_showFeedback") ?? sliderShowFeedback;
    sliderPressDelay = p.getConfig("${sliderPrefix}_pressDelay") ?? sliderPressDelay;

    switchWidth = p.getConfig("${switchPrefix}_width") ?? switchWidth;
    switchHeight = p.getConfig("${switchPrefix}_height") ?? switchHeight;
    switchTouchPadding = p.getConfig("${switchPrefix}_touchPadding") ?? switchTouchPadding;
    switchColor = p.getConfig("${switchPrefix}_color") ?? switchColor;
    switchEnableHaptic = p.getConfig("${switchPrefix}_enableHaptic") ?? switchEnableHaptic;
    switchShowFeedback = p.getConfig("${switchPrefix}_showFeedback") ?? sliderShowFeedback;
    switchPressDelay = p.getConfig("${switchPrefix}_pressDelay") ?? switchPressDelay;

    textfieldWidth = p.getConfig("${textfieldPrefix}_width") ?? textfieldWidth;
    textfieldHeight = p.getConfig("${textfieldPrefix}_height") ?? textfieldHeight;
    textfieldTouchPadding = p.getConfig("${textfieldPrefix}_touchPadding") ?? textfieldTouchPadding;
    textfieldPadding = p.getConfig("${textfieldPrefix}_padding") ?? textfieldPadding;
    textfieldColor = p.getConfig("${textfieldPrefix}_color") ?? textfieldColor;
    textfieldEnableHaptic = p.getConfig("${textfieldPrefix}_enableHaptic") ?? textfieldEnableHaptic;
    textfieldShowFeedback = p.getConfig("${textfieldPrefix}_showFeedback") ?? textfieldShowFeedback;
    textfieldPressDelay = p.getConfig("${textfieldPrefix}_pressDelay") ?? textfieldPressDelay;

    dropdownWidth = p.getConfig("${dropdownPrefix}_width") ?? dropdownWidth;
    dropdownHeight = p.getConfig("${dropdownPrefix}_height") ?? dropdownHeight;
    dropdownTouchPadding = p.getConfig("${dropdownPrefix}_touchPadding") ?? dropdownTouchPadding;
    dropdownPadding = p.getConfig("${dropdownPrefix}_padding") ?? dropdownPadding;
    dropdownColor = p.getConfig("${dropdownPrefix}_color") ?? dropdownColor;
    dropdownListColor = p.getConfig("${dropdownPrefix}_listColor") ?? dropdownListColor;
    dropdownEnableHaptic = p.getConfig("${dropdownPrefix}_enableHaptic") ?? dropdownEnableHaptic;
    dropdownShowFeedback = p.getConfig("${dropdownPrefix}_showFeedback") ?? dropdownShowFeedback;
    dropdownPressDelay = p.getConfig("${dropdownPrefix}_pressDelay") ?? dropdownPressDelay;

    overviewCardHeight = p.getConfig("${overviewCardPrefix}_height") ?? overviewCardHeight;
    overviewCardTouchPadding =
        p.getConfig("${overviewCardPrefix}_touchPadding") ?? overviewCardTouchPadding;
    overviewCardColor = p.getConfig("${overviewCardPrefix}_color") ?? overviewCardColor;
    overviewCardSurfaceTintColor =
        p.getConfig("${overviewCardPrefix}_surfaceTintColor") ?? overviewCardSurfaceTintColor;
    overviewCardEnableHaptic =
        p.getConfig("${overviewCardPrefix}_enableHaptic") ?? overviewCardEnableHaptic;
    overviewCardShowFeedback =
        p.getConfig("${overviewCardPrefix}_showFeedback") ?? overviewCardShowFeedback;
    overviewCardPressDelay = p.getConfig("${overviewCardPrefix}_pressDelay") ?? overviewCardPressDelay;
    overviewCardFeedbackText =
        p.getConfig("${overviewCardPrefix}_feedbackText") ?? overviewCardFeedbackText;
    overviewCardFeedbackController = TextEditingController(text: overviewCardFeedbackText);
    taskCardPadding = p.getConfig("${taskCardPrefix}_padding") ?? taskCardPadding;
    taskCardActionBarHeight =
        p.getConfig("${taskCardPrefix}_actionBarHeight") ?? taskCardActionBarHeight;
    taskCardBackgroundColor =
        p.getConfig("${taskCardPrefix}_backgroundColor") ?? taskCardBackgroundColor;
    taskCardActionBarColor = p.getConfig("${taskCardPrefix}_actionBarColor") ?? taskCardActionBarColor;
    sideMenuWidth = p.getConfig('sidemenu_width') ?? sideMenuWidth;
    sideMenuBackgroundColor = p.getConfig('sidemenu_backgroundColor') ?? sideMenuBackgroundColor;
  }

  @override
  void dispose() {
    overviewCardFeedbackController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final p = Provider.of<UserComponentProvider>(context, listen: false);

    return DraggableScrollableSheet(
      initialChildSize: 0.9,
      maxChildSize: 0.95,
      builder: (_, controller) {
        return Container(
          decoration: const BoxDecoration(
            color: Color(0xFFF5F6F8),
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: ListView(
            controller: controller,
            padding: const EdgeInsets.all(16),
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      assistiveComponentNamePt(widget.component),
                      style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                  ),
                  IconButton(
                    tooltip: "Fechar",
                    onPressed: () => Navigator.of(context).maybePop(),
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              if (widget.component == "Checkbox")
                section("Checkbox", [
                  sliderRow(
                    label: "Scale",
                    value: checkboxScale,
                    min: 1,
                    max: 10,
                    context: context,
                    onChanged: (v) => setState(() => checkboxScale = v),
                  ),
                  sliderRow(
                    label: "Padding",
                    value: checkboxPadding,
                    min: 0,
                    max: 40,
                    context: context,
                    onChanged: (v) => setState(() => checkboxPadding = v),
                  ),
                  sliderRow(
                    label: "Touch Padding",
                    value: checkboxTouchPadding,
                    min: 0,
                    max: 40,
                    context: context,
                    onChanged: (v) => setState(() => checkboxTouchPadding = v),
                  ),
                  sliderRow(
                    label: "Press Delay (ms)",
                    value: checkboxPressDelay,
                    min: 0,
                    max: 1000,
                    context: context,
                    onChanged: (v) => setState(() => checkboxPressDelay = v),
                  ),
                  colorRow(
                    label: "Color",
                    value: checkboxColor,
                    context: context,
                    onChanged: (c) => setState(() => checkboxColor = c),
                  ),
                  switchRow(
                    label: "Haptic",
                    value: checkboxEnableHaptic,
                    context: context,
                    onChanged: (v) => setState(() => checkboxEnableHaptic = v),
                  ),
                  switchRow(
                    label: "Feedback",
                    value: checkboxShowFeedback,
                    context: context,
                    onChanged: (v) => setState(() => checkboxShowFeedback = v),
                  ),
                ]),

              if (widget.component == "TextField")
                section("Textfield", [
                  sliderRow(
                    label: "Width",
                    value: textfieldWidth,
                    min: 30,
                    max: 400,
                    context: context,
                    onChanged: (v) => setState(() => textfieldWidth = v),
                  ),
                  sliderRow(
                    label: "Height",
                    value: textfieldHeight,
                    min: 10,
                    max: 300,
                    context: context,
                    onChanged: (v) => setState(() => textfieldHeight = v),
                  ),
                  sliderRow(
                    label: "Padding",
                    value: textfieldPadding,
                    min: 0,
                    context: context,
                    max: 40,
                    onChanged: (v) => setState(() => textfieldPadding = v),
                  ),
                  sliderRow(
                    label: "Touch Padding",
                    value: textfieldTouchPadding,
                    min: 0,
                    max: 40,
                    context: context,
                    onChanged: (v) => setState(() => textfieldTouchPadding = v),
                  ),
                  sliderRow(
                    label: "Press Delay (ms)",
                    value: textfieldPressDelay,
                    min: 0,
                    max: 1000,
                    context: context,
                    onChanged: (v) => setState(() => textfieldPressDelay = v),
                  ),
                  colorRow(
                    label: "Color",
                    value: textfieldColor,
                    context: context,
                    onChanged: (c) => setState(() => textfieldColor = c),
                  ),
                  switchRow(
                    label: "Haptic",
                    value: textfieldEnableHaptic,
                    context: context,
                    onChanged: (v) => setState(() => textfieldEnableHaptic = v),
                  ),
                  switchRow(
                    label: "Feedback",
                    value: textfieldShowFeedback,
                    context: context,
                    onChanged: (v) => setState(() => textfieldShowFeedback = v),
                  ),
                ]),

              if (widget.component == "Dropdown")
                section("Dropdown", [
                  sliderRow(
                    label: "Width",
                    value: dropdownWidth,
                    min: 30,
                    max: 400,
                    context: context,
                    onChanged: (v) => setState(() => dropdownWidth = v),
                  ),
                  sliderRow(
                    label: "Height",
                    value: dropdownHeight,
                    min: 10,
                    max: 300,
                    context: context,
                    onChanged: (v) => setState(() => dropdownHeight = v),
                  ),
                  sliderRow(
                    label: "Padding",
                    value: dropdownPadding,
                    min: 0,
                    max: 40,
                    context: context,
                    onChanged: (v) => setState(() => dropdownPadding = v),
                  ),
                  sliderRow(
                    label: "Touch Padding",
                    value: dropdownTouchPadding,
                    min: 0,
                    max: 40,
                    context: context,
                    onChanged: (v) => setState(() => dropdownTouchPadding = v),
                  ),
                  sliderRow(
                    label: "Press Delay (ms)",
                    value: dropdownPressDelay,
                    min: 0,
                    context: context,
                    max: 1000,
                    onChanged: (v) => setState(() => dropdownPressDelay = v),
                  ),
                  colorRow(
                    label: "Color",
                    value: dropdownColor,
                    context: context,
                    onChanged: (c) => setState(() => dropdownColor = c),
                  ),
                  colorRow(
                    label: "List Color",
                    context: context,
                    value: dropdownListColor,
                    onChanged: (c) => setState(() => dropdownListColor = c),
                  ),
                  switchRow(
                    label: "Haptic",
                    context: context,
                    value: dropdownEnableHaptic,
                    onChanged: (v) => setState(() => dropdownEnableHaptic = v),
                  ),
                  switchRow(
                    label: "Feedback",
                    context: context,
                    value: dropdownShowFeedback,
                    onChanged: (v) => setState(() => dropdownShowFeedback = v),
                  ),
                ]),

              if (widget.component == "Overview Card")
                section("Overview Card", [
                  sliderRow(
                    label: "Height",
                    value: overviewCardHeight,
                    min: 40,
                    max: 320,
                    context: context,
                    onChanged: (v) => setState(() => overviewCardHeight = v),
                  ),
                  sliderRow(
                    label: "Touch Padding",
                    value: overviewCardTouchPadding,
                    min: 0,
                    max: 40,
                    context: context,
                    onChanged: (v) => setState(() => overviewCardTouchPadding = v),
                  ),
                  colorRow(
                    label: "Color",
                    value: overviewCardColor,
                    context: context,
                    onChanged: (c) => setState(() => overviewCardColor = c),
                  ),
                  colorRow(
                    label: "Surface Tint Color",
                    value: overviewCardSurfaceTintColor,
                    context: context,
                    onChanged: (c) => setState(() => overviewCardSurfaceTintColor = c),
                  ),
                  switchRow(
                    label: "Haptic",
                    value: overviewCardEnableHaptic,
                    context: context,
                    onChanged: (v) => setState(() => overviewCardEnableHaptic = v),
                  ),
                  switchRow(
                    label: "Feedback",
                    value: overviewCardShowFeedback,
                    context: context,
                    onChanged: (v) => setState(() => overviewCardShowFeedback = v),
                  ),
                  section("Feedback Text", [
                    TextField(
                      controller: overviewCardFeedbackController,
                      decoration: const InputDecoration(border: OutlineInputBorder()),
                      onChanged: (value) => overviewCardFeedbackText = value,
                    ),
                  ]),
                  sliderRow(
                    label: "Press Delay (ms)",
                    value: overviewCardPressDelay,
                    min: 0,
                    max: 1000,
                    context: context,
                    onChanged: (v) => setState(() => overviewCardPressDelay = v),
                    showInt: true,
                  ),
                ]),

              if (widget.component == "Task Card")
                section("Task Card", [
                  sliderRow(
                    label: "Padding",
                    value: taskCardPadding,
                    min: 0,
                    max: 48,
                    context: context,
                    onChanged: (v) => setState(() => taskCardPadding = v),
                  ),
                  sliderRow(
                    label: "Action Bar Height",
                    value: taskCardActionBarHeight,
                    min: 40,
                    max: 120,
                    context: context,
                    onChanged: (v) => setState(() => taskCardActionBarHeight = v),
                  ),
                  colorRow(
                    label: "Background Color",
                    value: taskCardBackgroundColor,
                    context: context,
                    onChanged: (c) => setState(() => taskCardBackgroundColor = c),
                  ),
                  colorRow(
                    label: "Action Bar Color",
                    value: taskCardActionBarColor,
                    context: context,
                    onChanged: (c) => setState(() => taskCardActionBarColor = c),
                  ),
                ]),

              if (widget.component == "Side Menu")
                section("Side Menu", [
                  sliderRow(
                    label: "Width",
                    value: sideMenuWidth,
                    min: 240,
                    max: 420,
                    context: context,
                    onChanged: (v) => setState(() => sideMenuWidth = v),
                  ),
                  colorRow(
                    label: "Background Color",
                    value: sideMenuBackgroundColor,
                    context: context,
                    onChanged: (c) => setState(() => sideMenuBackgroundColor = c),
                  ),
                ]),

              if (widget.component == "Slider")
                section("Slider", [
                  sliderRow(
                    label: "Width",
                    context: context,
                    value: sliderWidth,
                    min: 16,
                    max: 300,
                    onChanged: (v) => setState(() => sliderWidth = v),
                  ),
                  sliderRow(
                    label: "Height",
                    context: context,
                    value: sliderHeight,
                    min: 8,
                    max: 40,
                    onChanged: (v) => setState(() => sliderHeight = v),
                  ),
                  sliderRow(
                    label: "Padding",
                    context: context,
                    value: sliderPadding,
                    min: 0,
                    max: 40,
                    onChanged: (v) => setState(() => sliderPadding = v),
                  ),
                  sliderRow(
                    label: "Touch Padding",
                    context: context,
                    value: sliderTouchPadding,
                    min: 0,
                    max: 128,
                    onChanged: (v) => setState(() => sliderTouchPadding = v),
                  ),
                  sliderRow(
                    label: "Press Delay (ms)",
                    context: context,
                    value: sliderPressDelay,
                    min: 0,
                    max: 1000,
                    onChanged: (v) => setState(() => sliderPressDelay = v),
                  ),
                  colorRow(
                    label: "Color",
                    context: context,
                    value: sliderActiveColor,
                    onChanged: (c) => setState(() => sliderActiveColor = c),
                  ),
                  colorRow(
                    label: "Inactive Color",
                    context: context,
                    value: sliderInactiveColor,
                    onChanged: (c) => setState(() => sliderInactiveColor = c),
                  ),
                  switchRow(
                    label: "Haptic",
                    context: context,
                    value: sliderEnableHaptic,
                    onChanged: (v) => setState(() => sliderEnableHaptic = v),
                  ),
                  switchRow(
                    label: "Feedback",
                    context: context,
                    value: sliderShowFeedback,
                    onChanged: (v) => setState(() => sliderShowFeedback = v),
                  ),
                ]),

              if (widget.component == "Switch")
                section("Switch", [
                  sliderRow(
                    label: "Width",
                    context: context,
                    value: switchWidth,
                    min: 16,
                    max: 300,
                    onChanged: (v) => setState(() => switchWidth = v),
                  ),
                  sliderRow(
                    label: "Height",
                    context: context,
                    value: switchHeight,
                    min: 8,
                    max: 300,
                    onChanged: (v) => setState(() => switchHeight = v),
                  ),
                  sliderRow(
                    label: "Touch Padding",
                    context: context,
                    value: switchTouchPadding,
                    min: 0,
                    max: 128,
                    onChanged: (v) => setState(() => switchTouchPadding = v),
                  ),
                  sliderRow(
                    label: "Press Delay (ms)",
                    value: switchPressDelay,
                    context: context,
                    min: 0,
                    max: 1000,
                    onChanged: (v) => setState(() => switchPressDelay = v),
                  ),
                  colorRow(
                    label: "Color",
                    value: switchColor,
                    context: context,
                    onChanged: (c) => setState(() => switchColor = c),
                  ),
                  switchRow(
                    label: "Haptic",
                    value: switchEnableHaptic,
                    context: context,
                    onChanged: (v) => setState(() => switchEnableHaptic = v),
                  ),
                  switchRow(
                    label: "Feedback",
                    value: switchShowFeedback,
                    context: context,
                    onChanged: (v) => setState(() => switchShowFeedback = v),
                  ),
                ]),

              if (widget.component == "Radio")
                section("Radio", [
                  sliderRow(
                    label: "Size",
                    value: radioSize,
                    context: context,
                    min: 1,
                    max: 40,
                    onChanged: (v) => setState(() => radioSize = v),
                  ),
                  sliderRow(
                    context: context,
                    label: "Padding",
                    value: radioPadding,
                    min: 0,
                    max: 40,
                    onChanged: (v) => setState(() => radioPadding = v),
                  ),
                  sliderRow(
                    context: context,
                    label: "Touch Padding",
                    value: radioTouchPadding,
                    min: 0,
                    max: 40,
                    onChanged: (v) => setState(() => radioTouchPadding = v),
                  ),
                  sliderRow(
                    context: context,
                    label: "Press Delay (ms)",
                    value: radioPressDelay,
                    min: 0,
                    max: 1000,
                    onChanged: (v) => setState(() => radioPressDelay = v),
                  ),
                  colorRow(
                    context: context,
                    label: "Color",
                    value: radioColor,
                    onChanged: (c) => setState(() => radioColor = c),
                  ),
                  switchRow(
                    context: context,
                    label: "Haptic",
                    value: radioEnableHaptic,
                    onChanged: (v) => setState(() => radioEnableHaptic = v),
                  ),
                  switchRow(
                    context: context,
                    label: "Feedback",
                    value: radioShowFeedback,
                    onChanged: (v) => setState(() => radioShowFeedback = v),
                  ),
                ]),

              if (["Button"].contains(widget.component))
                section("Layout", [
                  sliderRow(
                    label: "Width",
                    value: buttonWidth,
                    context: context,
                    min: 12,
                    max: 240,
                    onChanged: (v) => setState(() => buttonWidth = v),
                  ),
                  sliderRow(
                    label: "Height",
                    value: buttonHeight,
                    min: 12,
                    context: context,
                    max: 240,
                    onChanged: (v) => setState(() => buttonHeight = v),
                  ),
                ]),
              if (["Button"].contains(widget.component))
                section("Spacing", [
                  sliderRow(
                    label: "Padding",
                    value: buttonPadding,
                    context: context,
                    min: 0,
                    max: 36,
                    onChanged: (v) => setState(() => buttonPadding = v),
                  ),
                  sliderRow(
                    label: "Touch Padding",
                    value: buttonTouchPadding,
                    context: context,
                    min: 0,
                    max: 36,
                    onChanged: (v) => setState(() => buttonTouchPadding = v),
                  ),
                ]),
              if (["Button"].contains(widget.component))
                section("Interaction", [
                  sliderRow(
                    label: "Press Delay (ms)",
                    value: buttonPressDelayMs,
                    min: 0,
                    max: 5000,
                    context: context,
                    onChanged: (v) => setState(() => buttonPressDelayMs = v),
                    showInt: true,
                  ),
                  switchRow(
                    label: "Haptic",
                    value: buttonEnableHaptic,
                    context: context,
                    onChanged: (v) => setState(() => buttonEnableHaptic = v),
                  ),
                  switchRow(
                    label: "Feedback",
                    value: buttonShowFeedback,
                    context: context,
                    onChanged: (v) => setState(() => buttonShowFeedback = v),
                  ),
                ]),
              if (["Button"].contains(widget.component))
                section("Button", [
                  sliderRow(
                    label: "Font Size",
                    context: context,
                    value: buttonFontSize,
                    min: 8,
                    max: 36,
                    onChanged: (v) => setState(() => buttonFontSize = v),
                  ),
                  colorRow(
                    label: "Color",
                    context: context,
                    value: buttonColor,
                    onChanged:
                        (c) => setState(() {
                          buttonColor = c;
                        }),
                  ),
                  colorRow(
                    label: "Font Color",
                    context: context,
                    value: buttonFontColor,
                    onChanged:
                        (c) => setState(() {
                          buttonFontColor = c;
                        }),
                  ),
                ]),

              if (["Big Button"].contains(widget.component))
                section("Layout", [
                  sliderRow(
                    label: "Width",
                    value: bigButtonWidth,
                    context: context,
                    min: 12,
                    max: 240,
                    onChanged: (v) => setState(() => bigButtonWidth = v),
                  ),
                  sliderRow(
                    label: "Height",
                    value: bigButtonHeight,
                    min: 12,
                    context: context,
                    max: 240,
                    onChanged: (v) => setState(() => bigButtonHeight = v),
                  ),
                ]),
              if (["Big Button"].contains(widget.component))
                section("Spacing", [
                  sliderRow(
                    label: "Padding",
                    value: bigButtonPadding,
                    context: context,
                    min: 0,
                    max: 36,
                    onChanged: (v) => setState(() => bigButtonPadding = v),
                  ),
                  sliderRow(
                    label: "Touch Padding",
                    value: bigButtonTouchPadding,
                    context: context,
                    min: 0,
                    max: 36,
                    onChanged: (v) => setState(() => bigButtonTouchPadding = v),
                  ),
                ]),
              if (["Big Button"].contains(widget.component))
                section("Interaction", [
                  sliderRow(
                    label: "Press Delay (ms)",
                    value: bigButtonPressDelayMs,
                    min: 0,
                    max: 5000,
                    context: context,
                    onChanged: (v) => setState(() => bigButtonPressDelayMs = v),
                    showInt: true,
                  ),
                  switchRow(
                    label: "Haptic",
                    value: bigButtonEnableHaptic,
                    context: context,
                    onChanged: (v) => setState(() => bigButtonEnableHaptic = v),
                  ),
                  switchRow(
                    label: "Feedback",
                    value: bigButtonShowFeedback,
                    context: context,
                    onChanged: (v) => setState(() => bigButtonShowFeedback = v),
                  ),
                ]),
              if (["Big Button"].contains(widget.component))
                section("Button", [
                  sliderRow(
                    label: "Font Size",
                    context: context,
                    value: bigButtonFontSize,
                    min: 8,
                    max: 36,
                    onChanged: (v) => setState(() => bigButtonFontSize = v),
                  ),
                  colorRow(
                    label: "Color",
                    context: context,
                    value: bigButtonColor,
                    onChanged:
                        (c) => setState(() {
                          bigButtonColor = c;
                        }),
                  ),
                  colorRow(
                    label: "Font Color",
                    context: context,
                    value: bigButtonFontColor,
                    onChanged:
                        (c) => setState(() {
                          bigButtonFontColor = c;
                        }),
                  ),
                ]),

              if (["Text Button"].contains(widget.component))
                section("Layout", [
                  sliderRow(
                    label: "Width",
                    value: textButtonWidth,
                    context: context,
                    min: 12,
                    max: 240,
                    onChanged: (v) => setState(() => textButtonWidth = v),
                  ),
                  sliderRow(
                    label: "Height",
                    value: textButtonHeight,
                    min: 12,
                    context: context,
                    max: 240,
                    onChanged: (v) => setState(() => textButtonHeight = v),
                  ),
                ]),
              if (["Text Button"].contains(widget.component))
                section("Spacing", [
                  sliderRow(
                    label: "Padding",
                    value: textButtonPadding,
                    context: context,
                    min: 0,
                    max: 36,
                    onChanged: (v) => setState(() => textButtonPadding = v),
                  ),
                  sliderRow(
                    label: "Touch Padding",
                    value: textButtonTouchPadding,
                    context: context,
                    min: 0,
                    max: 36,
                    onChanged: (v) => setState(() => textButtonTouchPadding = v),
                  ),
                ]),
              if (["Text Button"].contains(widget.component))
                section("Interaction", [
                  sliderRow(
                    label: "Press Delay (ms)",
                    value: textButtonPressDelayMs,
                    min: 0,
                    max: 5000,
                    context: context,
                    onChanged: (v) => setState(() => textButtonPressDelayMs = v),
                    showInt: true,
                  ),
                  switchRow(
                    label: "Haptic",
                    value: textButtonEnableHaptic,
                    context: context,
                    onChanged: (v) => setState(() => textButtonEnableHaptic = v),
                  ),
                  switchRow(
                    label: "Feedback",
                    value: textButtonShowFeedback,
                    context: context,
                    onChanged: (v) => setState(() => textButtonShowFeedback = v),
                  ),
                ]),
              if (["Text Button"].contains(widget.component))
                section("Button", [
                  sliderRow(
                    label: "Font Size",
                    context: context,
                    value: textButtonFontSize,
                    min: 8,
                    max: 36,
                    onChanged: (v) => setState(() => textButtonFontSize = v),
                  ),
                  colorRow(
                    label: "Color",
                    context: context,
                    value: textButtonColor,
                    onChanged:
                        (c) => setState(() {
                          textButtonColor = c;
                        }),
                  ),
                  colorRow(
                    label: "Font Color",
                    context: context,
                    value: textButtonFontColor,
                    onChanged:
                        (c) => setState(() {
                          textButtonFontColor = c;
                        }),
                  ),
                ]),

              if (["Icon Button"].contains(widget.component))
                section("Layout", [
                  sliderRow(
                    label: "Width",
                    context: context,
                    value: iconButtonWidth,
                    min: 12,
                    max: 240,
                    onChanged: (v) => setState(() => iconButtonWidth = v),
                  ),
                  sliderRow(
                    label: "Height",
                    context: context,
                    value: iconButtonHeight,
                    min: 12,
                    max: 240,
                    onChanged: (v) => setState(() => iconButtonHeight = v),
                  ),
                  sliderRow(
                    label: "Border Radius",
                    context: context,
                    value: iconButtonBorderRadius,
                    min: 0,
                    max: 50,
                    onChanged: (v) => setState(() => iconButtonBorderRadius = v),
                  ),
                ]),
              if (["Icon Button"].contains(widget.component))
                section("Spacing", [
                  sliderRow(
                    label: "Padding",
                    context: context,
                    value: iconButtonPadding,
                    min: 0,
                    max: 36,
                    onChanged: (v) => setState(() => iconButtonPadding = v),
                  ),
                  sliderRow(
                    label: "Touch Padding",
                    context: context,
                    value: iconButtonTouchPadding,
                    min: 0,
                    max: 36,
                    onChanged: (v) => setState(() => iconButtonTouchPadding = v),
                  ),
                ]),
              if (["Icon Button"].contains(widget.component))
                section("Interaction", [
                  sliderRow(
                    label: "Press Delay (ms)",
                    value: iconButtonPressDelay,
                    context: context,
                    min: 0,
                    max: 5000,
                    onChanged: (v) => setState(() => iconButtonPressDelay = v),
                    showInt: true,
                  ),
                  switchRow(
                    label: "Haptic",
                    context: context,
                    value: iconButtonEnableHaptic,
                    onChanged: (v) => setState(() => iconButtonEnableHaptic = v),
                  ),
                  switchRow(
                    label: "Feedback",
                    context: context,
                    value: iconButtonShowFeedback,
                    onChanged: (v) => setState(() => iconButtonShowFeedback = v),
                  ),
                ]),
              if (["Icon Button"].contains(widget.component))
                section("Icon", [
                  sliderRow(
                    label: "Icon Size",
                    context: context,
                    value: iconButtonIconSize,
                    min: 8,
                    max: 36,
                    onChanged: (v) => setState(() => iconButtonIconSize = v),
                  ),
                  colorRow(
                    label: "Button Color",
                    value: iconButtonColor,
                    context: context,
                    onChanged:
                        (c) => setState(() {
                          iconButtonColor = c;
                        }),
                  ),
                  colorRow(
                    label: "Icon Color",
                    value: iconButtonIconColor,
                    context: context,
                    onChanged:
                        (c) => setState(() {
                          iconButtonIconColor = c;
                        }),
                  ),
                ]),

              if (widget.component == "Linear Progress")
                section("Linear Progress", [
                  sliderRow(
                    label: "Width",
                    context: context,
                    value: linearProgressWidth,
                    min: 50,
                    max: 400,
                    onChanged: (v) => setState(() => linearProgressWidth = v),
                  ),
                  sliderRow(
                    label: "Height",
                    context: context,
                    value: linearProgressHeight,
                    min: 2,
                    max: 40,
                    onChanged: (v) => setState(() => linearProgressHeight = v),
                  ),
                  sliderRow(
                    label: "BorderRadius",
                    context: context,
                    value: linearProgressBorderRadius,
                    min: 0,
                    max: 30,
                    onChanged: (v) => setState(() => linearProgressBorderRadius = v),
                  ),
                  sliderRow(
                    label: "Animation (ms)",
                    context: context,
                    value: linearProgressAnimationDuration,
                    min: 0,
                    max: 2000,
                    onChanged: (v) => setState(() => linearProgressAnimationDuration = v),
                    showInt: true,
                  ),
                  colorRow(
                    label: "Border Color",
                    value: linearProgressBorder,
                    context: context,
                    onChanged: (c) => setState(() => linearProgressBorder = c),
                  ),
                  colorRow(
                    label: "Background Color",
                    value: linearProgressValueColor,
                    context: context,
                    onChanged: (c) => setState(() => linearProgressValueColor = c),
                  ),
                  switchRow(
                    label: "Show Label (%)",
                    value: linearProgressShowLabel,
                    context: context,
                    onChanged: (v) => setState(() => linearProgressShowLabel = v),
                  ),
                  colorRow(
                    label: "Label Color",
                    context: context,
                    value: linearProgressLabelColor,
                    onChanged: (c) => setState(() => linearProgressLabelColor = c),
                  ),
                  switchRow(
                    label: "Animated",
                    context: context,
                    value: linearProgressAnimated,
                    onChanged: (v) => setState(() => linearProgressAnimated = v),
                  ),
                ]),

              if (widget.component == "Time Picker")
                section("Time Picker", [
                  sliderRow(
                    context: context,
                    label: "Width",
                    value: timePickerWidth,
                    min: 50,
                    max: 400,
                    onChanged: (v) => setState(() => timePickerWidth = v),
                  ),
                  sliderRow(
                    context: context,
                    label: "Height",
                    value: timePickerHeight,
                    min: 30,
                    max: 120,
                    onChanged: (v) => setState(() => timePickerHeight = v),
                  ),
                  sliderRow(
                    context: context,
                    label: "Padding",
                    value: timePickerPadding,
                    min: 0,
                    max: 40,
                    onChanged: (v) => setState(() => timePickerPadding = v),
                  ),
                  sliderRow(
                    context: context,
                    label: "Touch Padding",
                    value: timePickerTouchPadding,
                    min: 0,
                    max: 40,
                    onChanged: (v) => setState(() => timePickerTouchPadding = v),
                  ),
                  sliderRow(
                    context: context,
                    label: "Press Delay (ms)",
                    value: timePickerPressDelay,
                    min: 0,
                    max: 5000,
                    showInt: true,
                    onChanged: (v) => setState(() => timePickerPressDelay = v),
                  ),
                  colorRow(
                    context: context,
                    label: "Background Color",
                    value: timePickerColor,
                    onChanged: (c) => setState(() => timePickerColor = c),
                  ),
                  colorRow(
                    context: context,
                    label: "Font Color",
                    value: timePickerFontColor,
                    onChanged: (c) => setState(() => timePickerFontColor = c),
                  ),
                  sliderRow(
                    context: context,
                    label: "Font Size",
                    value: timePickerFontSize,
                    min: 0,
                    max: 48,
                    showInt: true,
                    onChanged: (v) => setState(() => timePickerFontSize = v),
                  ),
                  switchRow(
                    context: context,
                    label: "Haptic",
                    value: timePickerEnableHaptic,
                    onChanged: (v) => setState(() => timePickerEnableHaptic = v),
                  ),
                  switchRow(
                    context: context,
                    label: "Feedback",
                    value: timePickerShowFeedback,
                    onChanged: (v) => setState(() => timePickerShowFeedback = v),
                  ),
                ]),

              if (widget.component == "Tab Bar")
                section("Tab Bar", [
                  sliderRow(
                    label: "Height",
                    value: tabBarHeight,
                    context: context,
                    min: 40,
                    max: 120,
                    onChanged: (v) => setState(() => tabBarHeight = v),
                  ),
                  sliderRow(
                    label: "Padding",
                    value: tabBarPadding,
                    context: context,
                    min: 0,
                    max: 40,
                    onChanged: (v) => setState(() => tabBarPadding = v),
                  ),
                  sliderRow(
                    label: "Press Delay (ms)",
                    value: tabBarPressDelay,
                    context: context,
                    min: 0,
                    max: 5000,
                    showInt: true,
                    onChanged: (v) => setState(() => tabBarPressDelay = v),
                  ),
                  colorRow(
                    label: "Background Color",
                    value: tabBarBackgroundColor,
                    context: context,
                    onChanged: (c) => setState(() => tabBarBackgroundColor = c),
                  ),
                  switchRow(
                    label: "Haptic",
                    value: tabBarEnableHaptic,
                    context: context,
                    onChanged: (v) => setState(() => tabBarEnableHaptic = v),
                  ),
                  switchRow(
                    label: "Feedback",
                    value: tabBarShowFeedback,
                    context: context,
                    onChanged: (v) => setState(() => tabBarShowFeedback = v),
                  ),
                  switchRow(
                    label: "Icon",
                    context: context,
                    value: tabBarShowIcon,
                    onChanged: (v) => setState(() => tabBarShowIcon = v),
                  ),
                ]),

              if (widget.component == "Alert Dialog")
                section("Alert Dialog", [
                  sliderRow(
                    label: "Width",
                    value: alertDialogWidth,
                    context: context,
                    min: 200,
                    max: 500,
                    onChanged: (v) => setState(() => alertDialogWidth = v),
                  ),
                  sliderRow(
                    label: "Padding",
                    value: alertDialogPadding,
                    context: context,
                    min: 0,
                    max: 40,
                    onChanged: (v) => setState(() => alertDialogPadding = v),
                  ),
                  sliderRow(
                    label: "Border Radius",
                    value: alertDialogBorderRadius,
                    min: 0,
                    context: context,
                    max: 50,
                    onChanged: (v) => setState(() => alertDialogBorderRadius = v),
                  ),
                  colorRow(
                    label: "Dialog Background Color",
                    value: alertDialogBackgroundColor,
                    context: context,
                    onChanged: (c) => setState(() => alertDialogBackgroundColor = c),
                  ),
                  colorRow(
                    label: "Title Color",
                    value: alertDialogTitleColor,
                    context: context,
                    onChanged: (c) => setState(() => alertDialogTitleColor = c),
                  ),
                  colorRow(
                    label: "Content Color",
                    value: alertDialogContentColor,
                    context: context,
                    onChanged: (c) => setState(() => alertDialogContentColor = c),
                  ),
                  switchRow(
                    label: "Haptic",
                    value: alertDialogEnableHaptic,
                    context: context,
                    onChanged: (v) => setState(() => alertDialogEnableHaptic = v),
                  ),
                  switchRow(
                    label: "Feedback",
                    value: alertDialogShowFeedback,
                    context: context,
                    onChanged: (v) => setState(() => alertDialogShowFeedback = v),
                  ),
                  sliderRow(
                    label: "Press Delay (ms)",
                    value: alertDialogPressDelay.inMilliseconds.toDouble(),
                    min: 0,
                    max: 2000,
                    context: context,
                    onChanged: (v) => setState(
                      () => alertDialogPressDelay = Duration(milliseconds: v.toInt()),
                    ),
                    showInt: true,
                  ),
                ]),
              if (widget.component == "Alert Dialog")
                section("Confirm Button", [
                  sliderRow(
                    label: "Width",
                    context: context,
                    value: alertDialogConfirmWidth,
                    min: 40,
                    max: 240,
                    onChanged: (v) => setState(() => alertDialogConfirmWidth = v),
                  ),
                  sliderRow(
                    label: "Height",
                    value: alertDialogConfirmHeight,
                    min: 40,
                    context: context,
                    max: 240,
                    onChanged: (v) => setState(() => alertDialogConfirmHeight = v),
                  ),
                  sliderRow(
                    label: "Border Radius",
                    value: alertDialogConfirmBorderRadius,
                    min: 0,
                    max: 50,
                    context: context,
                    onChanged: (v) => setState(() => alertDialogConfirmBorderRadius = v),
                  ),
                  colorRow(
                    label: "Confirm Button Background Color",
                    value: alertDialogConfirmBackgroundColor,
                    context: context,
                    onChanged: (c) => setState(() => alertDialogConfirmBackgroundColor = c),
                  ),
                  colorRow(
                    label: "Confirm Button Text Color",
                    value: alertDialogConfirmTextColor,
                    context: context,
                    onChanged: (c) => setState(() => alertDialogConfirmTextColor = c),
                  ),
                ]),
              if (widget.component == "Alert Dialog")
                section("Cancel Button", [
                  sliderRow(
                    label: "Width",
                    value: alertDialogCancelWidth,
                    min: 40,
                    max: 240,
                    context: context,
                    onChanged: (v) => setState(() => alertDialogCancelWidth = v),
                  ),
                  sliderRow(
                    label: "Height",
                    value: alertDialogCancelHeight,
                    min: 40,
                    max: 240,
                    context: context,
                    onChanged: (v) => setState(() => alertDialogCancelHeight = v),
                  ),
                  sliderRow(
                    label: "Border Radius",
                    context: context,
                    value: alertDialogCancelBorderRadius,
                    min: 0,
                    max: 50,
                    onChanged: (v) => setState(() => alertDialogCancelBorderRadius = v),
                  ),
                  colorRow(
                    label: "Cancel Button Background Color",
                    value: alertDialogCancelBackgroundColor,
                    context: context,
                    onChanged: (c) => setState(() => alertDialogCancelBackgroundColor = c),
                  ),
                  colorRow(
                    label: "Cancel Button Text Color",
                    value: alertDialogCancelTextColor,
                    context: context,
                    onChanged: (c) => setState(() => alertDialogCancelTextColor = c),
                  ),
                ]),

              if (widget.component == "Bottom Bar")
                section("Bottom Bar", [
                  sliderRow(
                    label: "Opacity",
                    value: bottomBarOpacity,
                    min: 0.0,
                    max: 1.0,
                    context: context,
                    onChanged: (v) => setState(() => bottomBarOpacity = v),
                  ),
                  sliderRow(
                    label: "Margin",
                    value: bottomBarMargin,
                    min: 0,
                    max: 40,
                    context: context,
                    onChanged: (v) => setState(() => bottomBarMargin = v),
                  ),
                  sliderRow(
                    label: "Item Padding Horizontal",
                    value: bottomBarItemPaddingHorizontal,
                    min: 0,
                    max: 40,
                    context: context,
                    onChanged: (v) => setState(() => bottomBarItemPaddingHorizontal = v),
                  ),
                  sliderRow(
                    label: "Item Padding Vertical",
                    value: bottomBarItemPaddingVertical,
                    min: 0,
                    max: 40,
                    context: context,
                    onChanged: (v) => setState(() => bottomBarItemPaddingVertical = v),
                  ),
                  sliderRow(
                    label: "Press Delay (ms)",
                    value: bottomBarPressDelay,
                    min: 0,
                    max: 5000,
                    context: context,
                    showInt: true,
                    onChanged: (v) => setState(() => bottomBarPressDelay = v),
                  ),
                  colorRow(
                    label: "Background Color",
                    value: bottomBarBackgroundColor,
                    context: context,
                    onChanged: (c) => setState(() => bottomBarBackgroundColor = c),
                  ),
                  colorRow(
                    label: "Inactive Color",
                    value: bottomBarInactiveColor,
                    context: context,
                    onChanged: (c) => setState(() => bottomBarInactiveColor = c),
                  ),
                  switchRow(
                    label: "Haptic",
                    value: bottomBarEnableHaptic,
                    context: context,
                    onChanged: (v) => setState(() => bottomBarEnableHaptic = v),
                  ),
                  switchRow(
                    label: "Feedback",
                    value: bottomBarShowFeedback,
                    context: context,
                    onChanged: (v) => setState(() => bottomBarShowFeedback = v),
                  ),
                ]),

              saveButton(() {
                for (final componentPrefix in presetScalableComponentPrefixes) {
                  if (componentPrefix == prefix) {
                    p.setConfig('${componentPrefix}_$presetSizeMultiplierProperty', 1.0);
                  }
                }
                p.setConfig('activePreset', 'custom');
                p.configWriteComponent = prefix;

                p.setConfig("linearprogress_borderRadius", linearProgressBorderRadius);
                p.setConfig("linearprogress_animationDuration", linearProgressAnimationDuration);
                p.setConfig("linearprogress_valueColor", linearProgressValueColor);
                p.setConfig("linearprogress_color", linearProgressColor);
                p.setConfig("linearprogress_showLabel", linearProgressShowLabel);
                p.setConfig("linearprogress_animated", linearProgressAnimated);
                p.setConfig("linearprogress_height", linearProgressHeight);
                p.setConfig("linearprogress_width", linearProgressWidth);
                p.setConfig("linearprogress_borderColor", linearProgressBorder);
                p.setConfig("linearprogress_labelColor", linearProgressLabelColor);

                p.setConfig("button_width", buttonWidth);
                p.setConfig("button_height", buttonHeight);
                p.setConfig("button_padding", buttonPadding);
                p.setConfig("button_touchPadding", buttonTouchPadding);
                p.setConfig("button_fontSize", buttonFontSize);
                p.setConfig("button_color", buttonColor);
                p.setConfig("button_fontColor", buttonFontColor);
                p.setConfig("button_pressDelay", buttonPressDelayMs);
                p.setConfig("button_enableHaptic", buttonEnableHaptic);
                p.setConfig("button_showFeedback", buttonShowFeedback);

                p.setConfig("bigbutton_width", bigButtonWidth);
                p.setConfig("bigbutton_height", bigButtonHeight);
                p.setConfig("bigbutton_padding", bigButtonPadding);
                p.setConfig("bigbutton_touchPadding", bigButtonTouchPadding);
                p.setConfig("bigbutton_fontSize", bigButtonFontSize);
                p.setConfig("bigbutton_color", bigButtonColor);
                p.setConfig("bigbutton_fontColor", bigButtonFontColor);
                p.setConfig("bigbutton_pressDelay", bigButtonPressDelayMs);
                p.setConfig("bigbutton_enableHaptic", bigButtonEnableHaptic);
                p.setConfig("bigbutton_showFeedback", bigButtonShowFeedback);

                p.setConfig("textbutton_width", textButtonWidth);
                p.setConfig("textbutton_height", textButtonHeight);
                p.setConfig("textbutton_padding", textButtonPadding);
                p.setConfig("textbutton_touchPadding", textButtonTouchPadding);
                p.setConfig("textbutton_fontSize", textButtonFontSize);
                p.setConfig("textbutton_color", textButtonColor);
                p.setConfig("textbutton_fontColor", textButtonFontColor);
                p.setConfig("textbutton_pressDelay", textButtonPressDelayMs);
                p.setConfig("textbutton_enableHaptic", textButtonEnableHaptic);
                p.setConfig("textbutton_showFeedback", textButtonShowFeedback);

                p.setConfig("iconbutton_width", iconButtonWidth);
                p.setConfig("iconbutton_height", iconButtonHeight);
                p.setConfig("iconbutton_padding", iconButtonPadding);
                p.setConfig("iconbutton_touchPadding", iconButtonTouchPadding);
                p.setConfig("iconbutton_iconSize", iconButtonIconSize);
                p.setConfig("iconbutton_color", iconButtonColor);
                p.setConfig("iconbutton_iconColor", iconButtonIconColor);
                p.setConfig("iconbutton_pressDelay", iconButtonPressDelay);
                p.setConfig("iconbutton_enableHaptic", iconButtonEnableHaptic);
                p.setConfig("iconbutton_showFeedback", iconButtonShowFeedback);

                p.setConfig("timepicker_width", timePickerWidth);
                p.setConfig("timepicker_height", timePickerHeight);
                p.setConfig("timepicker_padding", timePickerPadding);
                p.setConfig("timepicker_touchPadding", timePickerTouchPadding);
                p.setConfig("timepicker_color", timePickerColor);
                p.setConfig("timepicker_fontColor", timePickerFontColor);
                p.setConfig("timepicker_fontSize", timePickerFontSize);
                p.setConfig("timepicker_enableHaptic", timePickerEnableHaptic);
                p.setConfig("timepicker_showFeedback", timePickerShowFeedback);
                p.setConfig("timepicker_pressDelay", timePickerPressDelay);

                p.setConfig("tabbar_height", tabBarHeight);
                p.setConfig("tabbar_padding", tabBarPadding);
                p.setConfig("tabbar_backgroundColor", tabBarBackgroundColor);
                p.setConfig("tabbar_enableHaptic", tabBarEnableHaptic);
                p.setConfig("tabbar_showFeedback", tabBarShowFeedback);
                p.setConfig("tabbar_showIcon", tabBarShowIcon);
                p.setConfig("tabbar_pressDelay", tabBarPressDelay);

                p.setConfig("alertdialog_titleColor", alertDialogTitleColor);
                p.setConfig("alertdialog_contentColor", alertDialogContentColor);
                p.setConfig("alertdialog_backgroundColor", alertDialogBackgroundColor);
                p.setConfig("alertdialog_enableHaptic", alertDialogEnableHaptic);
                p.setConfig("alertdialog_showFeedback", alertDialogShowFeedback);
                p.setConfig("alertdialog_width", alertDialogWidth);
                p.setConfig("alertdialog_padding", alertDialogPadding);
                p.setConfig("alertdialog_borderRadius", alertDialogBorderRadius);
                p.setConfig("alertdialog_pressDelay", alertDialogPressDelay);
                p.setConfig("alertdialog_confirmWidth", alertDialogConfirmWidth);
                p.setConfig("alertdialog_confirmHeight", alertDialogConfirmHeight);
                p.setConfig("alertdialog_confirmRadius", alertDialogConfirmBorderRadius);
                p.setConfig("alertdialog_confirmBg", alertDialogConfirmBackgroundColor);
                p.setConfig("alertdialog_confirmTextColor", alertDialogConfirmTextColor);
                p.setConfig("alertdialog_cancelWidth", alertDialogCancelWidth);
                p.setConfig("alertdialog_cancelHeight", alertDialogCancelHeight);
                p.setConfig("alertdialog_cancelBorderRadius", alertDialogCancelBorderRadius);
                p.setConfig("alertdialog_cancelBg", alertDialogCancelBackgroundColor);
                p.setConfig("alertdialog_cancelTextColor", alertDialogCancelTextColor);

                p.setConfig("bottombar_itemPaddingHorizontal", bottomBarItemPaddingHorizontal);
                p.setConfig("bottombar_itemPaddingVertical", bottomBarItemPaddingVertical);
                p.setConfig("bottombar_margin", bottomBarMargin);
                p.setConfig("bottombar_pressDelay", bottomBarPressDelay);
                p.setConfig("bottombar_opacity", bottomBarOpacity);
                p.setConfig("bottombar_backgroundColor", bottomBarBackgroundColor);
                p.setConfig("bottombar_inactiveColor", bottomBarInactiveColor);
                p.setConfig("bottombar_enableHaptic", bottomBarEnableHaptic);
                p.setConfig("bottombar_showFeedback", bottomBarShowFeedback);

                p.setConfig("checkbox_scale", checkboxScale);
                p.setConfig("checkbox_padding", checkboxPadding);
                p.setConfig("checkbox_touchPadding", checkboxTouchPadding);
                p.setConfig("checkbox_color", checkboxColor);
                p.setConfig("checkbox_enableHaptic", checkboxEnableHaptic);
                p.setConfig("checkbox_showFeedback", checkboxShowFeedback);
                p.setConfig("checkbox_pressDelay", checkboxPressDelay);

                p.setConfig("radio_size", radioSize);
                p.setConfig("radio_touchPadding", radioTouchPadding);
                p.setConfig("radio_padding", radioPadding);
                p.setConfig("radio_color", radioColor);
                p.setConfig("radio_enableHaptic", radioEnableHaptic);
                p.setConfig("radio_showFeedback", radioShowFeedback);
                p.setConfig("radio_pressDelay", radioPressDelay);

                p.setConfig("slider_width", sliderWidth);
                p.setConfig("slider_height", sliderHeight);
                p.setConfig("slider_touchPadding", sliderTouchPadding);
                p.setConfig("slider_padding", sliderPadding);
                p.setConfig("slider__activeColor", sliderActiveColor);
                p.setConfig("slider_Inactivecolor", sliderActiveColor);
                p.setConfig("slider_enableHaptic", sliderEnableHaptic);
                p.setConfig("slider_showFeedback", sliderShowFeedback);
                p.setConfig("slider_pressDelay", sliderPressDelay);

                p.setConfig("switch_width", switchWidth);
                p.setConfig("switch_height", switchHeight);
                p.setConfig("switch_touchPadding", switchTouchPadding);
                p.setConfig("switch_color", switchColor);
                p.setConfig("switch_enableHaptic", switchEnableHaptic);
                p.setConfig("switch_showFeedback", switchShowFeedback);
                p.setConfig("switch_pressDelay", switchPressDelay);

                p.setConfig("textfield_width", textfieldWidth);
                p.setConfig("textfield_height", textfieldHeight);
                p.setConfig("textfield_touchPadding", textfieldTouchPadding);
                p.setConfig("textfield_padding", textfieldPadding);
                p.setConfig("textfield_color", textfieldColor);
                p.setConfig("textfield_enableHaptic", textfieldEnableHaptic);
                p.setConfig("textfield_showFeedback", textfieldShowFeedback);
                p.setConfig("textfield_pressDelay", textfieldPressDelay);

                p.setConfig("dropdown_width", dropdownWidth);
                p.setConfig("dropdown_height", dropdownHeight);
                p.setConfig("dropdown_touchPadding", dropdownTouchPadding);
                p.setConfig("dropdown_padding", dropdownPadding);
                p.setConfig("dropdown_color", dropdownColor);
                p.setConfig("dropdown_listColor", dropdownListColor);
                p.setConfig("dropdown_enableHaptic", dropdownEnableHaptic);
                p.setConfig("dropdown_showFeedback", dropdownShowFeedback);
                p.setConfig("dropdown_pressDelay", dropdownPressDelay);

                p.setConfig("overviewcard_height", overviewCardHeight);
                p.setConfig("overviewcard_touchPadding", overviewCardTouchPadding);
                p.setConfig("overviewcard_color", overviewCardColor);
                p.setConfig("overviewcard_surfaceTintColor", overviewCardSurfaceTintColor);
                p.setConfig("overviewcard_enableHaptic", overviewCardEnableHaptic);
                p.setConfig("overviewcard_showFeedback", overviewCardShowFeedback);
                p.setConfig("overviewcard_pressDelay", overviewCardPressDelay);
                p.setConfig("overviewcard_feedbackText", overviewCardFeedbackText);

                p.setConfig("taskcard_padding", taskCardPadding);
                p.setConfig("taskcard_actionBarHeight", taskCardActionBarHeight);
                p.setConfig("taskcard_backgroundColor", taskCardBackgroundColor);
                p.setConfig("taskcard_actionBarColor", taskCardActionBarColor);

                p.setConfig('sidemenu_width', sideMenuWidth);
                p.setConfig('sidemenu_backgroundColor', sideMenuBackgroundColor);

                p.configWriteComponent = null;
                Navigator.pop(context);
              }),
            ],
          ),
        );
      },
    );
  }
}
