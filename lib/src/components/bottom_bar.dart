// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:flutter_assistive_ui_components/src/helpers/preset_size_multiplier.dart';
import 'package:flutter_assistive_ui_components/src/internal/floating_feedback.dart';
import 'package:flutter_assistive_ui_components/src/providers/providers.dart';

class AssistiveUIBottomBar extends StatefulWidget {
  final int currentIndex;
  final ValueChanged<int>? onChanged;
  final List<SalomonBottomBarItem> items;

  final Color backgroundColor;
  final Color inactiveColor;
  final Curve curve;
  final Duration animationDuration;
  final double selectedColorOpacity;

  final double itemPaddingHorizontal;
  final double itemPaddingVertical;
  final double margin;

  final ShapeBorder itemShape;
  final bool enableHaptic;
  final bool showFeedback;
  final Duration pressDelay;

  const AssistiveUIBottomBar({
    super.key,
    required this.currentIndex,
    required this.items,
    required this.onChanged,
    this.backgroundColor = const Color.fromARGB(50, 243, 243, 243),
    this.inactiveColor = Colors.grey,
    this.curve = Curves.easeOutCubic,
    this.animationDuration = const Duration(milliseconds: 250),
    this.selectedColorOpacity = 0.2,
    this.itemPaddingVertical = 12,
    this.itemPaddingHorizontal = 16,
    this.margin = 0,
    this.itemShape = const StadiumBorder(),
    this.enableHaptic = true,
    this.showFeedback = true,
    this.pressDelay = Duration.zero,
  });

  @override
  State<AssistiveUIBottomBar> createState() => _AssistiveUIBottomBarState();
}

class _AssistiveUIBottomBarState extends State<AssistiveUIBottomBar> {
  late int _currentIndex;

  static const prefix = "bottombar";
  static const double baseIconSize = 24;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.currentIndex;
  }

  Future<void> _handleTap(
    int index,
    bool enableHaptic,
    bool showFeedback,
    Duration delay,
  ) async {
    if (delay > Duration.zero) {
      await Future.delayed(delay);
    }

    if (enableHaptic) {
      HapticFeedback.selectionClick();
    }

    setState(() => _currentIndex = index);
    widget.onChanged?.call(index);

    if (showFeedback) {
      showFloatingFeedback(context, "Aba alterada");
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<UserComponentProvider>();
    final multiplier = getPresetSizeMultiplier(provider, prefix);

    final backgroundColor =
        provider.getConfig<Color>("${prefix}_backgroundColor") ??
        widget.backgroundColor;
    final inactiveColor =
        provider.getConfig<Color>("${prefix}_inactiveColor") ??
        widget.inactiveColor;
    final enableHaptic =
        provider.getConfig<bool>("${prefix}_enableHaptic") ??
        widget.enableHaptic;
    final showFeedback =
        provider.getConfig<bool>("${prefix}_showFeedback") ??
        widget.showFeedback;
    final pressDelayMs =
        provider.getConfig<double>("${prefix}_pressDelay") ?? 0;
    final pressDelay = Duration(milliseconds: pressDelayMs.toInt());
    final opacity =
        provider.getConfig<double>("${prefix}_opacity") ??
        widget.selectedColorOpacity;
    final itemPaddingVertical = getScaledPresetConfig(
      provider,
      prefix,
      'itemPaddingVertical',
      widget.itemPaddingVertical,
    );
    final itemPaddingHorizontal = getScaledPresetConfig(
      provider,
      prefix,
      'itemPaddingHorizontal',
      widget.itemPaddingHorizontal,
    );
    final margin = getScaledPresetConfig(
      provider,
      prefix,
      'margin',
      widget.margin,
    );

    // Tudo escala junto com o preset: ícone, texto, paddings e a barra inteira.
    final iconSize = baseIconSize * multiplier;
    final itemHeight = iconSize + itemPaddingVertical * 2;
    final textScale = MediaQuery.of(context).textScaler.scale(1.0) * multiplier;

    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: margin + 12,
        vertical: margin + 6,
      ),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(itemHeight / 2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 18,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      // Altura FINITA antes do FittedBox: o Scaffold passa constraints com
      // altura ilimitada para o bottomNavigationBar e um FittedBox direto
      // se dimensionaria para maxHeight (infinito), esticando a barra pela
      // tela inteira.
      child: SizedBox(
        height: itemHeight + 6,
        // Itens de largura natural (comportamento do Salomon original, por isso
        // o texto fica legível); em telas estreitas a barra inteira encolhe
        // UNIFORMEMENTE via scaleDown — mesmo comportamento em todos os presets,
        // sem transbordar e sem esconder o texto só do item selecionado.
        child: FittedBox(
          fit: BoxFit.scaleDown,
          alignment: Alignment.center,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              for (var i = 0; i < widget.items.length; i++)
                _BottomBarItem(
                  item: widget.items[i],
                  selected: i == _currentIndex,
                  onTap:
                      () =>
                          _handleTap(i, enableHaptic, showFeedback, pressDelay),
                  inactiveColor: inactiveColor,
                  selectedColorOpacity: opacity,
                  itemShape: widget.itemShape,
                  iconSize: iconSize,
                  itemHeight: itemHeight,
                  itemPaddingHorizontal: itemPaddingHorizontal,
                  textScale: textScale,
                  duration:
                      widget.animationDuration == Duration.zero
                          ? const Duration(milliseconds: 250)
                          : widget.animationDuration,
                  curve: widget.curve,
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BottomBarItem extends StatelessWidget {
  const _BottomBarItem({
    required this.item,
    required this.selected,
    required this.onTap,
    required this.inactiveColor,
    required this.selectedColorOpacity,
    required this.itemShape,
    required this.iconSize,
    required this.itemHeight,
    required this.itemPaddingHorizontal,
    required this.textScale,
    required this.duration,
    required this.curve,
  });

  final SalomonBottomBarItem item;
  final bool selected;
  final VoidCallback onTap;
  final Color inactiveColor;
  final double selectedColorOpacity;
  final ShapeBorder itemShape;
  final double iconSize;
  final double itemHeight;
  final double itemPaddingHorizontal;
  final double textScale;
  final Duration duration;
  final Curve curve;

  @override
  Widget build(BuildContext context) {
    final selectedColor =
        item.selectedColor ?? Theme.of(context).colorScheme.primary;

    // O texto do item escala com o preset via textScaler (o widget.title
    // é um Text sem estilo explícito), combinando com o ícone escalado.
    final itemMediaQuery = MediaQuery.of(
      context,
    ).copyWith(textScaler: TextScaler.linear(textScale));

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: AnimatedContainer(
          duration: duration,
          curve: curve,
          height: itemHeight,
          padding: EdgeInsets.symmetric(horizontal: itemPaddingHorizontal),
          decoration: ShapeDecoration(
            color:
                selected
                    ? selectedColor.withValues(alpha: selectedColorOpacity)
                    : Colors.transparent,
            shape: itemShape,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              IconTheme(
                data: IconThemeData(
                  size: iconSize,
                  color: selected ? selectedColor : inactiveColor,
                ),
                child:
                    selected && item.activeIcon != null
                        ? item.activeIcon!
                        : item.icon,
              ),
              AnimatedSize(
                duration: duration,
                curve: curve,
                alignment: AlignmentDirectional.centerStart,
                child:
                    selected
                        ? Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: itemPaddingHorizontal / 2,
                          ),
                          child: MediaQuery(
                            data: itemMediaQuery,
                            child: DefaultTextStyle.merge(
                              maxLines: 1,
                              softWrap: false,
                              overflow: TextOverflow.clip,
                              style: TextStyle(
                                color: selectedColor,
                                fontWeight: FontWeight.w600,
                                height: 1.0,
                              ),
                              child: item.title,
                            ),
                          ),
                        )
                        : const SizedBox.shrink(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
