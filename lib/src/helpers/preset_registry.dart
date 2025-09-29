import 'package:flutter_assistive_ui_components/src/providers/providers.dart';

/// Interface abstrata para aplicadores de presets
abstract class PresetApplier {
  /// Aplica o preset ao provider
  void apply(UserComponentProvider provider);

  /// Retorna o nome do preset
  String get name;

  /// Retorna uma descrição do preset
  String get description;
}

/// Registry centralizado para presets de acessibilidade
///
/// Este registry substitui o switch statement em preset_applier.dart,
/// permitindo:
/// - Registro dinâmico de novos presets
/// - Carregamento lazy de presets
/// - Melhor testabilidade
///
/// Uso:
/// ```dart
/// PresetRegistry.apply(context, 'aphasia');
/// ```
class PresetRegistry {
  static final Map<String, PresetApplier> _presets = {};

  static void _ensureInitialized() {
    if (_presets.isEmpty) {
      _registerDefaultPresets();
    }
  }

  /// Registra os presets padrão do sistema
  static void _registerDefaultPresets() {
    // Os presets são carregados lazy para evitar imports circulares
    // Será preenchido pela classe que inicializa o app
  }

  /// Registra um novo preset no registry
  static void register(String name, PresetApplier applier) {
    _presets[name.toLowerCase()] = applier;
  }

  /// Registra múltiplos presets de uma vez
  static void registerAll(Map<String, PresetApplier> presets) {
    for (final entry in presets.entries) {
      register(entry.key, entry.value);
    }
  }

  /// Aplica um preset ao provider
  static void apply(String presetName, UserComponentProvider provider) {
    _ensureInitialized();
    final preset = _presets[presetName.toLowerCase()];
    if (preset != null) {
      preset.apply(provider);
    } else {
      throw PresetNotFoundException(presetName);
    }
  }

  /// Retorna todos os presets disponíveis
  static List<PresetApplier> getAll() {
    _ensureInitialized();
    return _presets.values.toList();
  }

  /// Retorna um preset específico
  static PresetApplier? get(String presetName) {
    _ensureInitialized();
    return _presets[presetName.toLowerCase()];
  }

  /// Verifica se um preset existe
  static bool has(String presetName) {
    _ensureInitialized();
    return _presets.containsKey(presetName.toLowerCase());
  }

  /// Remove um preset do registry
  static void unregister(String presetName) {
    _presets.remove(presetName.toLowerCase());
  }

  /// Limpa todos os presets registrados
  static void clear() {
    _presets.clear();
  }
}

/// Exceção lançada quando um preset não é encontrado
class PresetNotFoundException implements Exception {
  final String presetName;

  PresetNotFoundException(this.presetName);

  @override
  String toString() => 'PresetNotFoundException: Preset "$presetName" não encontrado no registry';
}
