import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

Widget colorRow({
  required String label,
  required Color value,
  required ValueChanged<Color> onChanged,
  required context,
}) {
  final Color accent = Colors.blue;

  return Padding(
    padding: const EdgeInsets.only(bottom: 14),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 16)),
        const SizedBox(height: 8),

        InkWell(
          borderRadius: BorderRadius.circular(14),
          onTap: () async {
            Color temp = value;

            await showDialog(
              context: context,
              builder: (_) {
                return AlertDialog(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  title: const Text("Pick Color"),
                  content: SingleChildScrollView(
                    child: ColorPicker(pickerColor: value, onColorChanged: (c) => temp = c),
                  ),
                  actions: [
                    TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancel")),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: accent),
                      onPressed: () {
                        Navigator.pop(context);
                        onChanged(temp);
                      },
                      child: const Text("Apply"),
                    ),
                  ],
                );
              },
            );
          },
          child: Container(
            height: 56,
            width: double.infinity,
            decoration: BoxDecoration(
              color: value,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: Colors.black12),
            ),
          ),
        ),
      ],
    ),
  );
}
