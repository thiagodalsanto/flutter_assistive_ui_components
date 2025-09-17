import 'package:flutter/material.dart';

/// Classe base abstrata para todos os componentes interativos.
///
/// Define as propriedades comuns que todo componente interativo deve ter,
/// como delay de pressão, feedback háptico e feedback visual.
///
/// Esta classe garante consistência entre todos os componentes e
/// facilita a refatoração futura de propriedades comuns.
abstract class BaseInteractiveComponent extends StatefulWidget {
  /// Prefixo usado para recuperar configurações do provider
  /// Exemplo: "button" → "button_width", "button_height", etc.
  final String configPrefix;

  /// Delay entre o click e a execução da ação
  final Duration pressDelay;

  /// Se true, reproduz feedback háptico ao pressionar
  final bool enableHaptic;

  /// Duração do feedback háptico
  final Duration hapticDuration;

  /// Se true, mostra feedback visual flutuante
  final bool showFeedback;

  /// Texto exibido no feedback flutuante
  final String feedbackText;

  const BaseInteractiveComponent({
    required this.configPrefix,
    this.pressDelay = Duration.zero,
    this.enableHaptic = false,
    this.hapticDuration = const Duration(milliseconds: 30),
    this.showFeedback = false,
    this.feedbackText = 'Action performed',
    super.key,
  });
}
