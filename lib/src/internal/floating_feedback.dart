import 'package:flutter/material.dart';
import 'package:flutter_assistive_ui_components/src/internal/assistive_text_pt.dart';

/// Mostra um balão de feedback temporário no overlay.
///
/// Por padrão aparece no topo da tela (abaixo da status bar / safe area),
/// para não cobrir a bottom bar nem os botões do rodapé.
void showFloatingFeedback(BuildContext context, String message, {double? top}) {
  final overlay = Overlay.of(context);
  final localizedMessage = assistiveFeedbackPt(message);

  final effectiveTop = top ?? MediaQuery.of(context).padding.top + 16;

  final overlayEntry = OverlayEntry(
    builder:
        (context) => Positioned(
          top: effectiveTop,
          left: 24,
          right: 24,
          child: TweenAnimationBuilder<double>(
            tween: Tween(begin: 0, end: 1),
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeOutCubic,
            builder: (context, t, child) {
              return Opacity(
                opacity: t,
                child: Transform.translate(
                  offset: Offset(0, (1 - t) * -12),
                  child: child,
                ),
              );
            },
            child: Material(
              color: Colors.transparent,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: _barrierColor(context),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.1),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.25),
                      blurRadius: 16,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.check_circle_outline,
                      color: Colors.white.withValues(alpha: 0.9),
                      size: 20,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        localizedMessage,
                        textAlign: TextAlign.start,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          height: 1.3,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.2,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
  );

  overlay.insert(overlayEntry);

  Future.delayed(const Duration(seconds: 2), () {
    overlayEntry.remove();
  });
}

/// Cor de fundo do balão: acompanha o tema (claro/escuro) via inverseSurface.
Color _barrierColor(BuildContext context) {
  final inverse = Theme.of(context).colorScheme.inverseSurface;
  return inverse.withValues(alpha: 0.95);
}
