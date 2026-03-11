import 'package:audioplayers/audioplayers.dart';

class AudioService {
  static final AudioService _instance = AudioService._internal();
  factory AudioService() => _instance;
  AudioService._internal();

  final AudioPlayer _clickPlayer = AudioPlayer();
  final AudioPlayer _chimePlayer = AudioPlayer();

  bool isSoundEnabled = true;

  Future<void> playClick() async {
    if (!isSoundEnabled) return;
    try {
      print('AudioService: Intentando reproducir click.mp3');
      await _clickPlayer.stop();
      // En versiones recientes de audioplayers, el AssetSource asume carpeta assets/
      // pero a veces prefiere el path relativo completo según la configuración.
      await _clickPlayer.play(AssetSource('audio/click.mp3'));
    } catch (e) {
      print('AudioService Error (click): $e');
    }
  }

  Future<void> playChime() async {
    if (!isSoundEnabled) return;
    try {
      print('AudioService: Intentando reproducir chime.mp3');
      await _chimePlayer.stop();
      await _chimePlayer.play(AssetSource('audio/chime.mp3'));
    } catch (e) {
      print('AudioService Error (chime): $e');
    }
  }
  
  void dispose() {
    _clickPlayer.dispose();
    _chimePlayer.dispose();
  }
}
