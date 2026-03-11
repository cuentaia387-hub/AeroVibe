import 'dart:async';
import 'package:audioplayers/audioplayers.dart';

class AudioService {
  static final AudioService _instance = AudioService._internal();
  factory AudioService() => _instance;

  final AudioPlayer _clickPlayer = AudioPlayer();
  final AudioPlayer _chimePlayer = AudioPlayer();
  final Completer<void> _initCompleter = Completer<void>();

  bool isSoundEnabled = true;

  AudioService._internal() {
    _initializePlayers();
  }

  Future<void> _initializePlayers() async {
    try {
      // Modo de baja latencia para sonidos cortos de UI
      await _clickPlayer.setPlayerMode(PlayerMode.lowLatency);
      await _chimePlayer.setPlayerMode(PlayerMode.lowLatency);

      // Configuración global de audio para Android
      await AudioPlayer.global.setAudioContext(AudioContext(
        android: const AudioContextAndroid(
          usageType: AndroidUsageType.notification,
          contentType: AndroidContentType.sonification,
          audioFocus: AndroidAudioFocus.gainTransientMayDuck,
        ),
        iOS: AudioContextIOS(
          category: AVAudioSessionCategory.ambient,
          options: [
            AVAudioSessionOptions.mixWithOthers,
            AVAudioSessionOptions.duckOthers,
          ],
        ),
      ));

      // Habilitar logs para diagnóstico
      AudioLogger.logLevel = AudioLogLevel.info;
      
      // Warm-up: Cargar los sonidos preventivamente (setSource en lugar de play)
      await _clickPlayer.setSource(AssetSource('audio/click.mp3'));
      await _chimePlayer.setSource(AssetSource('audio/chime.mp3'));
      
      _initCompleter.complete();
      print('AudioService: Inicialización y warm-up completados');
    } catch (e) {
      print('AudioService: Error en inicialización: $e');
      if (!_initCompleter.isCompleted) _initCompleter.complete();
    }
  }

  Future<void> playClick() async {
    if (!isSoundEnabled) return;
    if (!_initCompleter.isCompleted) await _initCompleter.future;
    
    try {
      print('AudioService: Reproduciendo click.mp3');
      await _clickPlayer.stop();
      // En audioplayers 6+, el path es relativo a 'assets/'
      await _clickPlayer.play(AssetSource('audio/click.mp3'), volume: 1.0);
    } catch (e) {
      print('AudioService Error (click): $e');
    }
  }

  Future<void> playChime() async {
    if (!isSoundEnabled) return;
    if (!_initCompleter.isCompleted) await _initCompleter.future;

    try {
      print('AudioService: Reproduciendo chime.mp3');
      await _chimePlayer.stop();
      await _chimePlayer.play(AssetSource('audio/chime.mp3'), volume: 1.0);
    } catch (e) {
      print('AudioService Error (chime): $e');
    }
  }
  
  void dispose() {
    _clickPlayer.dispose();
    _chimePlayer.dispose();
  }
}
