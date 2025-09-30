import 'package:flutter_assistive_ui_components/src/internal/assistive_button/manual_config_sheet/component_config_sheet.dart';
import 'package:flutter/material.dart';

void openConfigSheet(BuildContext context, String component) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) => ComponentConfigSheet(component: component),
  );
}
