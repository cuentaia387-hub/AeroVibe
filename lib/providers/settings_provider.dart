import 'package:flutter/material.dart';
import '../services/audio_service.dart';

class SettingsProvider with ChangeNotifier {
  bool _soundEnabled = true;

  bool get soundEnabled => _soundEnabled;

  void toggleSound(bool value) {
    _soundEnabled = value;
    AudioService().isSoundEnabled = value;
    notifyListeners();
  }
}
