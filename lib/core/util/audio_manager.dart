import 'package:just_audio/just_audio.dart';

class AudioManager {
  static final AudioManager _instance = AudioManager._internal();

  factory AudioManager() => _instance;

  AudioManager._internal();

  final List<AudioPlayer> _players = [];

  void registerPlayer(AudioPlayer player) {
    _players.add(player);
  }

  void unregisterPlayer(AudioPlayer player) {
    _players.remove(player);
  }

  Future<void> stopAllExcept(AudioPlayer current) async {
    for (var player in _players) {
      if (player != current && player.playing) {
        await player.stop();
      }
    }
  }
}
