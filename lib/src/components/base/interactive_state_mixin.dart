import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_assistive_ui_components/src/internal/floating_feedback.dart';

/// Mixin que encapsula o comportamento comum de todos os componentes interativos.
///
/// Responsabilidades:
/// - Gerenciar estado de lock para evitar múltiplos cliques
/// - Aplicar delay configurável
/// - Executar feedback háptico
/// - Mostrar feedback flutuante
/// - Garantir segurança com mounted check
///
/// Uso:
/// ```dart
/// class _MyCustomButtonState extends State<MyCustomButton>
///     with InteractiveStateMixin<MyCustomButton> {
///
///   Future<void> _handlePress() => handleInteraction(
///     onAction: widget.onPressed,
///     feedbackText: 'Button pressed',
///   );
/// }
/// ```
mixin InteractiveStateMixin<W extends StatefulWidget> on State<W> {
  bool _locked = false;

  /// Executa uma ação interativa com feedback háptico, delay e feedback visual
  Future<void> handleInteraction({
    required VoidCallback onAction,
    required bool enableHaptic,
    required bool showFeedback,
    required Duration pressDelay,
    required Duration hapticDuration,
    String? feedbackText,
  }) async {
    if (_locked) return;

    setState(() => _locked = true);

    try {
      // Aplicar delay se configurado
      if (pressDelay > Duration.zero) {
        await Future.delayed(pressDelay);
      }

      // Feedback háptico
      if (enableHaptic) {
        HapticFeedback.mediumImpact();
        await Future.delayed(hapticDuration);
      }

      // Executar ação
      onAction();

      // Feedback visual flutuante
      if (showFeedback && feedbackText != null && mounted) {
        showFloatingFeedback(context, feedbackText);
      }
    } finally {
      // Sempre desbloquear, mesmo em caso de erro
      if (mounted) {
        setState(() => _locked = false);
      }
    }
  }

  /// Getter para verificar se o componente está em estado de lock
  bool get isLocked => _locked;
}
