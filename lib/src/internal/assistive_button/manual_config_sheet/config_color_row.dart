import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_assistive_ui_components/src/internal/assistive_text_pt.dart';

/// Linha de seleção de cor usada no modo Personalizado.
///
/// O dialog abre um editor RGB completo: sliders R / G / B / A em
/// passos de 1, campo Hexadecimal (aceita #RGB, #RRGGBB e #AARRGGBB)
/// e uma fileira de cores rápidas. O valor só é repassado ao
/// componente quando o usuário confirma em "Aplicar", preservando o
/// comportamento anterior da linha.

Widget colorRow({
  required String label,
  required Color value,
  required ValueChanged<Color> onChanged,
  required BuildContext context,
}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 14),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          assistiveConfigLabelPt(label),
          style: const TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 8),

        InkWell(
          borderRadius: BorderRadius.circular(14),
          onTap: () async {
            final result = await showDialog<Color>(
              context: context,
              builder: (_) => _ColorEditorDialog(initial: value),
            );

            if (result != null) onChanged(result);
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

class _ColorEditorDialog extends StatefulWidget {
  const _ColorEditorDialog({required this.initial});

  final Color initial;

  @override
  State<_ColorEditorDialog> createState() => _ColorEditorDialogState();
}

class _ColorEditorDialogState extends State<_ColorEditorDialog> {
  late Color _current = widget.initial;

  late final TextEditingController _hexController = TextEditingController(
    text: _hexText(_current),
  );

  late final FocusNode _hexFocus = FocusNode();

  static int _channel(Color color, int shift) =>
      (color.toARGB32() >> shift) & 0xFF;

  static String _hexText(Color color) {
    final rgb = (color.toARGB32() & 0xFFFFFF).toRadixString(16).padLeft(6, '0');
    return '#${rgb.toUpperCase()}';
  }

  /// Aceita #RGB / RGB, #RRGGBB / RRGGBB e #AARRGGBB / AARRGGBB.
  /// Sem alfa informado, mantém o alfa corrente.
  static ({int argb, bool hasAlpha})? _parseHex(String input) {
    final text = input.trim().replaceFirst(RegExp(r'^#+'), '');
    final value = int.tryParse(text, radix: 16);
    if (value == null) return null;

    switch (text.length) {
      case 3:
        final expanded = text
            .split('')
            .map((c) => c + c)
            .join(''); // #RGB → #RRGGBB
        final expandedValue = int.parse(expanded, radix: 16);
        return (argb: expandedValue, hasAlpha: false);
      case 6:
        return (argb: value, hasAlpha: false);
      case 8:
        return (argb: value, hasAlpha: true);
      default:
        return null;
    }
  }

  void _setColor(Color color) {
    setState(() {
      _current = color;
      if (!_hexFocus.hasFocus) {
        _hexController.text = _hexText(color);
      }
    });
  }

  void _submitHex(String input) {
    final parsed = _parseHex(input);
    if (parsed == null) {
      setState(() => _hexController.text = _hexText(_current));
      _hexFocus.unfocus();
      return;
    }

    final argb =
        parsed.hasAlpha
            ? parsed.argb
            : ((_current.toARGB32() & 0xFF000000) | (parsed.argb & 0xFFFFFF));

    _setColor(Color(argb));
    _hexFocus.unfocus();
  }

  @override
  void dispose() {
    _hexController.dispose();
    _hexFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Color accent = Colors.blue;

    Widget channelSlider({
      required String letter,
      required int shift,
      required Color activeColor,
    }) {
      final double value = _channel(_current, shift).toDouble();

      return Row(
        children: [
          SizedBox(
            width: 24,
            child: Text(
              letter,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
            ),
          ),
          Expanded(
            child: SliderTheme(
              data: SliderThemeData(
                trackHeight: 12,
                thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 15),
                overlayShape: const RoundSliderOverlayShape(overlayRadius: 26),
                activeTrackColor: activeColor,
                inactiveTrackColor: activeColor.withValues(alpha: 0.25),
                thumbColor: activeColor,
                overlayColor: activeColor.withValues(alpha: 0.2),
              ),
              child: Slider(
                value: value,
                max: 255,
                divisions: 255,
                onChanged: (v) {
                  final colorValue = v.round() & 0xFF;
                  final argb =
                      (_current.toARGB32() & ~(0xFF << shift)) |
                      (colorValue << shift);
                  _setColor(Color(argb));
                },
              ),
            ),
          ),
          SizedBox(
            width: 44,
            child: Text(
              value.round().toString(),
              textAlign: TextAlign.end,
              style: const TextStyle(
                fontFeatures: [FontFeature.tabularFigures()],
                fontSize: 14,
              ),
            ),
          ),
        ],
      );
    }

    Widget swatch(Color color, {String? tooltip}) {
      final bool selected = color.toARGB32() == _current.toARGB32();

      return Padding(
        padding: const EdgeInsets.only(right: 8),
        child: Tooltip(
          message: tooltip ?? '',
          child: InkWell(
            borderRadius: BorderRadius.circular(20),
            onTap: () => _setColor(color),
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
                border: Border.all(
                  color: selected ? accent : Colors.black12,
                  width: selected ? 3 : 1,
                ),
              ),
            ),
          ),
        ),
      );
    }

    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: const Text('Selecionar cor'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Pré-visualização + valor hexadecimal (edição direta).
            Row(
              children: [
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    color: _current,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: Colors.black12),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextField(
                    controller: _hexController,
                    focusNode: _hexFocus,
                    onSubmitted: _submitHex,
                    maxLength: 9,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                        RegExp(r'[0-9a-fA-F#]'),
                      ),
                    ],
                    decoration: InputDecoration(
                      counterText: '',
                      labelText: 'Hexadecimal',
                      hintText: '#RRGGBB',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      isDense: true,
                      suffixIcon: IconButton(
                        tooltip: 'Aplicar hexadecimal',
                        onPressed: () => _submitHex(_hexController.text),
                        icon: const Icon(Icons.check),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),
            const Text(
              'Canais',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 4),
            channelSlider(
              letter: 'R',
              shift: 16,
              activeColor: const Color(0xFFEF5350),
            ),
            channelSlider(
              letter: 'G',
              shift: 8,
              activeColor: const Color(0xFF66BB6A),
            ),
            channelSlider(
              letter: 'B',
              shift: 0,
              activeColor: const Color(0xFF42A5F5),
            ),
            channelSlider(
              letter: 'A',
              shift: 24,
              activeColor: const Color(0xFF9E9E9E),
            ),

            const SizedBox(height: 16),
            const Text(
              'Cores rápidas',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 8),
            Wrap(
              children: [
                swatch(const Color(0xFFFFFFFF), tooltip: 'Branco'),
                swatch(const Color(0xFF000000), tooltip: 'Preto'),
                swatch(const Color(0xFF808080), tooltip: 'Cinza'),
                swatch(const Color(0xFFD32F2F), tooltip: 'Vermelho'),
                swatch(const Color(0xFFF57C00), tooltip: 'Laranja'),
                swatch(const Color(0xFFFBC02D), tooltip: 'Amarelo'),
                swatch(const Color(0xFF388E3C), tooltip: 'Verde'),
                swatch(const Color(0xFF00897B), tooltip: 'Teal'),
                swatch(const Color(0xFF1976D2), tooltip: 'Azul'),
                swatch(const Color(0xFF7B1FA2), tooltip: 'Roxo'),
              ],
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancelar'),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: accent,
            foregroundColor: Colors.white,
          ),
          onPressed: () => Navigator.pop(context, _current),
          child: const Text('Aplicar'),
        ),
      ],
    );
  }
}
