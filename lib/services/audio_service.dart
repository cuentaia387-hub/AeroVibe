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
      await _clickPlayer.stop();
      await _clickPlayer.play(AssetSource('audio/click.mp3'));
    } catch (e) {
      print('Error playing click sound: $e');
    }
  }

  Future<void> playChime() async {
    if (!isSoundEnabled) return;
    try {
      await _chimePlayer.stop();
      await _chimePlayer.play(AssetSource('audio/chime.mp3'));
    } catch (e) {
      print('Error playing chime sound: $e');
    }
  }
  
  void dispose() {
    _clickPlayer.dispose();
    _chimePlayer.dispose();
  }
}
