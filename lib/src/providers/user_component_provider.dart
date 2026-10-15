import 'package:flutter/material.dart';

class UserComponentProvider extends ChangeNotifier {
  final Map<String, dynamic> _configs = {};
  final Map<String, double> _fineMotorBaselines = {};

  String? activeConfigComponent;
  String? configWriteComponent;

  T? getConfig<T>(String key) {
    if (_configs.containsKey(key)) return _configs[key] as T;
    return null;
  }

  void setConfig(String key, dynamic value) {
    final writeComponent = configWriteComponent;
    if (writeComponent != null &&
        key != 'activePreset' &&
        key.split('_').first.toLowerCase() != writeComponent) {
      return;
    }
    _configs[key] = value;
    notifyListeners();
  }

  double getOrStoreFineMotorBaseline(String key, double value) {
    return _fineMotorBaselines.putIfAbsent(key, () => value);
  }

  void clearConfigs() {
    _configs.clear();
    configWriteComponent = null;
    notifyListeners();
  }
}
