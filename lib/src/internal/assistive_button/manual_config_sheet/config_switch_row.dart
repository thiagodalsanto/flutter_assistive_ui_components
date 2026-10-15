// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_assistive_ui_components/src/internal/assistive_text_pt.dart';

Widget switchRow({
  required String label,
  required bool value,
  required ValueChanged<bool> onChanged,
  required context,
}) {
  final Color accent = Colors.blue;

  return Container(
    margin: const EdgeInsets.only(bottom: 12),
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    decoration: BoxDecoration(color: Colors.grey.shade50, borderRadius: BorderRadius.circular(14)),
    child: Row(
      children: [
        Expanded(child: Text(assistiveConfigLabelPt(label), style: const TextStyle(fontSize: 16))),
        Transform.scale(
          scale: 1.2,
          child: Switch(value: value, activeColor: accent, onChanged: onChanged),
        ),
      ],
    ),
  );
}
