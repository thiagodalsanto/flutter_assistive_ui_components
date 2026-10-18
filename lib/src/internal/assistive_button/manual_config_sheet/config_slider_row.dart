// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_assistive_ui_components/src/internal/assistive_text_pt.dart';

/// Crescimento máximo aceito no modo Personalizado.
const _maximumCustomGrowthPercent = 40.0;

/// Linha de slider do configurador manual.
///
/// Para props de tamanho, o slider mostra CRESCIMENTO em % sobre a
/// [baseline] — o valor com que a sheet abriu (o Fine/base do widget, ou o
/// estado efetivo já personalizado em uma edição anterior). Mover para 40%
/// grava um valor igual a 1.4 × base (mesmo aspecto do Severe).
Widget sliderRow({
  required String label,
  required double value,
  required double min,
  required double max,
  required ValueChanged<double> onChanged,
  required context,
  bool showInt = false,
  double? baseline,
}) {
  final Color accent = Colors.blue;

  final usesPercentage =
      !_isNonSizeValue(label) && baseline != null && baseline > 0;

  final sliderValue =
      usesPercentage
          ? ((value / baseline) - 1) * 100
          : value.clamp(min, _isInteractionDelay(label) ? 2000.0 : max);
  final clampedSliderValue =
      usesPercentage
          ? sliderValue.clamp(0.0, _maximumCustomGrowthPercent)
          : sliderValue;
  final sliderMin = usesPercentage ? 0.0 : min;
  final sliderMax =
      usesPercentage
          ? _maximumCustomGrowthPercent
          : (_isInteractionDelay(label) ? 2000.0 : max);
  final displayedValue =
      usesPercentage
          ? '${clampedSliderValue.round()}%'
          : showInt || _isInteractionDelay(label)
          ? clampedSliderValue.toInt().toString()
          : value.toStringAsFixed(1);

  return Padding(
    padding: const EdgeInsets.only(bottom: 14),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                assistiveConfigLabelPt(label),
                style: const TextStyle(fontSize: 16),
              ),
            ),
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
              value: clampedSliderValue,
              onChanged: (newValue) {
                onChanged(
                  usesPercentage
                      ? baseline *
                          (1 +
                              newValue.clamp(0.0, _maximumCustomGrowthPercent) /
                                  100)
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
    label.toLowerCase().contains('delay') ||
    label.toLowerCase().endsWith('(ms)');

bool _isNonSizeValue(String label) {
  final normalized = label.toLowerCase();
  return _isInteractionDelay(label) ||
      normalized.contains('animation') ||
      normalized.contains('opacity') ||
      normalized.contains('show label');
}
