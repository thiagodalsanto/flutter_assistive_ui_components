// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_assistive_ui_components/src/internal/assistive_text_pt.dart';

/// Builder consolidado para linhas de configuração repetitivas.
///
/// Este arquivo reduz 100+ linhas de código duplicado em 3 arquivos
/// (config_color_row.dart, config_slider_row.dart, config_switch_row.dart)
///
/// Uso:
/// ```dart
/// ConfigRowBuilder.colorRow(
///   label: 'Cor de fundo',
///   value: Colors.blue,
///   onChanged: (color) => provider.setConfig('button_color', color),
///   context: context,
/// )
/// ```
class ConfigRowBuilder {
  static const EdgeInsets _defaultRowPadding = EdgeInsets.only(bottom: 14);
  static const double _labelFontSize = 16;
  static const double _spacingBetweenLabelAndWidget = 8;

  /// Cria uma linha de configuração com label e conteúdo customizado
  static Widget buildRow(
    String label,
    List<Widget> children, {
    EdgeInsets padding = _defaultRowPadding,
  }) {
    return Padding(
      padding: padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            assistiveConfigLabelPt(label),
            style: const TextStyle(fontSize: _labelFontSize, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: _spacingBetweenLabelAndWidget),
          ...children,
        ],
      ),
    );
  }

  /// Cria uma linha de configuração de cor com color picker
  static Widget colorRow({
    required String label,
    required Color value,
    required ValueChanged<Color> onChanged,
    required BuildContext context,
  }) {
    return buildRow(label, [
      GestureDetector(
        onTap: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              Color tempColor = value;
              return AlertDialog(
                title: const Text('Selecionar Cor'),
                content: SingleChildScrollView(
                  child: ColorPicker(
                    color: value,
                    onColorChanged: (color) {
                      tempColor = color;
                    },
                  ),
                ),
                actions: [
                  TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancelar')),
                  TextButton(
                    onPressed: () {
                      onChanged(tempColor);
                      Navigator.pop(context);
                    },
                    child: const Text('Confirmar'),
                  ),
                ],
              );
            },
          );
        },
        child: Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: value,
            border: Border.all(color: Colors.grey, width: 2),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    ]);
  }

  /// Cria uma linha de configuração com slider
  static Widget sliderRow({
    required String label,
    required double value,
    required ValueChanged<double> onChanged,
    double min = 0,
    double max = 100,
    int divisions = 10,
    String Function(double)? labelFormatter,
  }) {
    final displayLabel = labelFormatter?.call(value) ?? value.toStringAsFixed(1);

    return buildRow(label, [
      Row(
        children: [
          Expanded(
            child: Slider(value: value, min: min, max: max, divisions: divisions, onChanged: onChanged),
          ),
          SizedBox(
            width: 60,
            child: Text(
              displayLabel,
              textAlign: TextAlign.right,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    ]);
  }

  /// Cria uma linha de configuração com switch
  static Widget switchRow({
    required String label,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return buildRow(label, [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text('Habilitado', style: TextStyle(fontSize: 14)),
          Switch(value: value, onChanged: onChanged),
        ],
      ),
    ]);
  }

  /// Cria uma linha de configuração com dropdown
  static Widget dropdownRow({
    required String label,
    required String value,
    required List<String> options,
    required ValueChanged<String?> onChanged,
  }) {
    return buildRow(label, [
      DropdownButton<String>(
        value: value,
        isExpanded: true,
        items:
            options.map((String option) {
              return DropdownMenuItem<String>(value: option, child: Text(assistiveConfigLabelPt(option)));
            }).toList(),
        onChanged: onChanged,
      ),
    ]);
  }

  /// Cria uma linha de configuração com campo de texto
  static Widget textFieldRow({
    required String label,
    required String value,
    required ValueChanged<String> onChanged,
    String hintText = '',
    int maxLines = 1,
  }) {
    return buildRow(label, [
      TextField(
        controller: TextEditingController(text: value),
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: assistiveConfigLabelPt(hintText),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        ),
        maxLines: maxLines,
      ),
    ]);
  }
}

/// Widget simples de seletor de cores
class ColorPicker extends StatefulWidget {
  final Color color;
  final ValueChanged<Color> onColorChanged;

  const ColorPicker({required this.color, required this.onColorChanged, super.key});

  @override
  State<ColorPicker> createState() => _ColorPickerState();
}

class _ColorPickerState extends State<ColorPicker> {
  late Color _selectedColor = widget.color;

  static final List<Color> _predefinedColors = [
    Colors.red,
    Colors.pink,
    Colors.purple,
    Colors.deepPurple,
    Colors.indigo,
    Colors.blue,
    Colors.lightBlue,
    Colors.cyan,
    Colors.teal,
    Colors.green,
    Colors.lightGreen,
    Colors.lime,
    Colors.yellow,
    Colors.amber,
    Colors.orange,
    Colors.deepOrange,
    Colors.brown,
    Colors.grey,
    Colors.blueGrey,
    Colors.black,
    Colors.white,
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Preview da cor selecionada
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            color: _selectedColor,
            border: Border.all(color: Colors.grey, width: 2),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        const SizedBox(height: 16),
        // Grade de cores predefinidas
        GridView.builder(
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 5,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
          ),
          itemCount: _predefinedColors.length,
          itemBuilder: (context, index) {
            final color = _predefinedColors[index];
            final isSelected = color.value == _selectedColor.value;

            return GestureDetector(
              onTap: () {
                setState(() => _selectedColor = color);
                widget.onColorChanged(color);
              },
              child: Container(
                decoration: BoxDecoration(
                  color: color,
                  border: Border.all(
                    color: isSelected ? Colors.black : Colors.grey,
                    width: isSelected ? 3 : 1,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
