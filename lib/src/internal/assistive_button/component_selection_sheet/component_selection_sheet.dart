// ignore_for_file: deprecated_member_use

import 'package:flutter_assistive_ui_components/src/internal/assistive_button/component_selection_sheet/get_icon.dart';
import 'package:flutter_assistive_ui_components/src/internal/assistive_button/component_selection_sheet/modern_button.dart';
import 'package:flutter_assistive_ui_components/src/internal/assistive_button/component_selection_sheet/open_config_sheet.dart';
import 'package:flutter/material.dart';

/// =======================================================
/// Component Selection Sheet
///
/// A UI layer that allows the user to select a UI component
/// type to configure.
///
/// This sheet:
/// - Displays a list/grid of available components
/// - Acts as entry point to the configuration system
/// - Navigates to ComponentConfigSheet after selection
///
/// It is part of a runtime UI customization system where
/// components can be modified dynamically without rebuilding
/// the app.
/// =======================================================

class ComponentSelectionSheet extends StatelessWidget {
  const ComponentSelectionSheet({super.key});

  static const components = [
    "Button",
    "Icon Button",
    "Checkbox",
    "Dropdown",
    "Radio",
    "Slider",
    "Switch",
    "TextField",
    "Linear Progress",
    "Time Picker",
    "Tab Bar",
    "Alert Dialog",
    "Bottom Bar",
  ];

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.55,
      minChildSize: 0.5,
      maxChildSize: 0.8,
      builder: (_, controller) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          decoration: const BoxDecoration(
            color: Color(0xFFF5F6F8),
            borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
          ),
          child: Column(
            children: [
              // Handle
              Container(
                width: 50,
                height: 6,
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: Colors.grey[400],
                  borderRadius: BorderRadius.circular(10),
                ),
              ),

              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Select Component",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
                ),
              ),

              const SizedBox(height: 20),

              Expanded(
                child: ListView.builder(
                  controller: controller,
                  itemCount: components.length,
                  itemBuilder: (context, index) {
                    final comp = components[index];
                    return modernButton(
                      context,
                      label: comp,
                      icon: getIcon(comp),
                      onTap: () {
                        Navigator.pop(context);
                        openConfigSheet(context, comp);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
