import 'package:flutter/material.dart';

IconData getIcon(String component) {
  switch (component) {
    case "Button":
      return Icons.smart_button;
    case "Big Button":
      return Icons.smart_button;
    case "Text Button":
      return Icons.smart_button;
    case "Icon Button":
      return Icons.radio_button_checked;
    case "Checkbox":
      return Icons.check_box;
    case "Dropdown":
      return Icons.arrow_drop_down_circle;
    case "Radio":
      return Icons.radio_button_on;
    case "Slider":
      return Icons.tune;
    case "Switch":
      return Icons.toggle_on;
    case "TextField":
      return Icons.text_fields;
    case "Calendar":
      return Icons.calendar_today;
    case "Linear Progress":
      return Icons.linear_scale;
    case "Time Picker":
      return Icons.access_time;
    case "Tab Bar":
      return Icons.tab;
    case "Overview Card":
      return Icons.view_day;
    case "Task Card":
      return Icons.task_alt;
    case "Side Menu":
      return Icons.menu;
    case "Alert Dialog":
      return Icons.warning_amber_outlined;
    case "Bottom Bar":
      return Icons.vertical_align_bottom;
    default:
      return Icons.widgets;
  }
}
