import 'package:flutter/material.dart';

class UserComponentProvider extends ChangeNotifier {
  final Map<String, dynamic> _configs = {};

  T? getConfig<T>(String key) {
    if (_configs.containsKey(key)) return _configs[key] as T;
    return null;
  }

  void setConfig(String key, dynamic value) {
    _configs[key] = value;
    notifyListeners();
  }
}
