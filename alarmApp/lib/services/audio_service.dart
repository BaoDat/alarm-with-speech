import 'package:audioplayers/audioplayers.dart';
import 'package:logging/logging.dart';

class AudioService {
  static final _log = Logger('AudioService');
  static final AudioPlayer _audioPlayer = AudioPlayer()
    ..setReleaseMode(ReleaseMode.stop);
  static bool _isPlaying = false;

  static Future<void> playAudio(String source) async {
    try {
      if (_isPlaying) {
        await _audioPlayer.stop();
        _isPlaying = false;
        return;
      }

      // Set audio context
      await _audioPlayer.setPlayerMode(PlayerMode.mediaPlayer);
      
      // Handle different source types
      if (source.startsWith('assets/')) {
        _log.info('Playing asset: $source');
        await _audioPlayer.play(AssetSource(source.replaceFirst('assets/', '')));
      } else {
        _log.info('Playing URL: $source');
        await _audioPlayer.play(UrlSource(source),
            mode: PlayerMode.mediaPlayer);
      }
      
      _isPlaying = true;

      // Add completion listener
      _audioPlayer.onPlayerComplete.listen((event) {
        _isPlaying = false;
      });

      // Add error listener
      // _audioPlayer.onPlayerError.listen((msg) {
      //   _log.severe('Player error: $msg');
      //   _isPlaying = false;
      // });

    } catch (e) {
      _log.severe('Error playing audio: $e');
      _isPlaying = false;
    }
  }

  static Future<void> stopAudio() async {
    try {
      await _audioPlayer.stop();
      _isPlaying = false;
    } catch (e) {
      _log.severe('Error stopping audio: $e');
    }
  }

  static void dispose() {
    _audioPlayer.dispose();
    _isPlaying = false;
  }
} 