// ignore_for_file: deprecated_member_use

import 'package:flutter_assistive_ui_components/src/helpers/preset_applier.dart';
import 'package:flutter/material.dart';
import '../component_selection_sheet/component_selection_sheet.dart';

class AccessibilityPresetSheet extends StatelessWidget {
  const AccessibilityPresetSheet({super.key});

  static const List<String> components = [
    "Button",
    "Icon Button",
    "Checkbox",
    "Dropdown",
    "Radio",
    "Slider",
    "Switch",
    "TextField",
    "Calendar",
    "Linear Progress",
    "Time Picker",
    "Tab Bar",
    "Alert Dialog",
    "Bottom Bar",
  ];

  Widget _modernButton(
    BuildContext context, {
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        elevation: 2,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: onTap,
          child: Container(
            height: 72,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Icon(icon, size: 28, color: Colors.blue),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(label, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                ),
                const Icon(Icons.arrow_forward_ios, size: 18),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.75,
      minChildSize: 0.75,
      maxChildSize: 0.75,
      builder: (_, controller) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          decoration: const BoxDecoration(
            color: Color(0xFFF5F6F8),
            borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
          ),
          child: Column(
            children: [
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
                  "Accessibility Presets",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
                ),
              ),
              const SizedBox(height: 20),

              Expanded(
                child: ListView(
                  controller: controller,
                  children: [
                    _modernButton(
                      context,
                      icon: Icons.pan_tool_alt,
                      label: "Fine Motor Mode",
                      onTap: () => applyPreset(context, "fine_motor"),
                    ),
                    _modernButton(
                      context,
                      icon: Icons.record_voice_over,
                      label: "Aphasia Mode",
                      onTap: () => applyPreset(context, "aphasia"),
                    ),
                    _modernButton(
                      context,
                      icon: Icons.accessibility_new,
                      label: "Severe Motor Impairment",
                      onTap: () => applyPreset(context, "severe_motor"),
                    ),
                    _modernButton(
                      context,
                      icon: Icons.settings,
                      label: "Manual Configuration",
                      onTap: () {
                        Navigator.pop(context);
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          builder: (_) => const ComponentSelectionSheet(),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
