// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

Widget sliderRow({
  required String label,
  required double value,
  required double min,
  required double max,
  required ValueChanged<double> onChanged,
  required context,
  bool showInt = false,
}) {
  final Color accent = Colors.blue;

  return Padding(
    padding: const EdgeInsets.only(bottom: 14),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(child: Text(label, style: const TextStyle(fontSize: 16))),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: accent.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                showInt ? value.toInt().toString() : value.toStringAsFixed(1),
                style: TextStyle(fontWeight: FontWeight.w600, color: accent),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),

        SizedBox(
          height: 48,
          child: SliderTheme(
            data: SliderTheme.of(context).copyWith(
              trackHeight: 6,
              thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 12),
              overlayShape: const RoundSliderOverlayShape(overlayRadius: 20),
              activeTrackColor: accent,
              thumbColor: accent,
              overlayColor: accent.withOpacity(0.2),
            ),
            child: Slider(min: min, max: max, value: value, onChanged: onChanged),
          ),
        ),
      ],
    ),
  );
}
