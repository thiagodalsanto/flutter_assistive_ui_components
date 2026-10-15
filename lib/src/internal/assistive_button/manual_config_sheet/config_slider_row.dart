// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_assistive_ui_components/src/internal/assistive_text_pt.dart';
import 'package:flutter_assistive_ui_components/src/providers/providers.dart';
import 'package:provider/provider.dart';

const _maximumCustomGrowthPercent = 40.0;

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
  final component = Provider.of<UserComponentProvider>(context, listen: false).activeConfigComponent;
  final usesPercentage = !_isNonSizeValue(label);
  final baselineKey = '$component|$label|$min|$max';
  final provider = Provider.of<UserComponentProvider>(context, listen: false);
  final baseline = usesPercentage ? provider.getOrStoreFineMotorBaseline(baselineKey, value) : value;
  final sliderValue = usesPercentage
      ? (baseline == 0 ? 0.0 : ((value / baseline) - 1) * 100).clamp(0.0, _maximumCustomGrowthPercent)
      : value.clamp(min, _isInteractionDelay(label) ? 2000.0 : max);
  final sliderMin = usesPercentage ? 0.0 : min;
  final sliderMax = usesPercentage
      ? _maximumCustomGrowthPercent
      : (_isInteractionDelay(label) ? 2000.0 : max);
  final displayedValue = usesPercentage
      ? '${sliderValue.round()}%'
      : showInt || _isInteractionDelay(label)
      ? sliderValue.toInt().toString()
      : value.toStringAsFixed(1);

  return Padding(
    padding: const EdgeInsets.only(bottom: 14),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(child: Text(assistiveConfigLabelPt(label), style: const TextStyle(fontSize: 16))),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: accent.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                displayedValue,
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
            child: Slider(
              min: sliderMin,
              max: sliderMax,
              value: sliderValue,
              onChanged: (newValue) {
                onChanged(
                  usesPercentage
                      ? baseline * (1 + newValue.clamp(0.0, _maximumCustomGrowthPercent) / 100)
                      : newValue,
                );
              },
            ),
          ),
        ),
      ],
    ),
  );
}

bool _isInteractionDelay(String label) =>
    label.toLowerCase().contains('delay') || label.toLowerCase().endsWith('(ms)');

bool _isNonSizeValue(String label) {
  final normalized = label.toLowerCase();
  return _isInteractionDelay(label) ||
      normalized.contains('animation') ||
      normalized.contains('opacity') ||
      normalized.contains('show label');
}
