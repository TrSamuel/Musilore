import 'package:just_audio/just_audio.dart';
import 'package:musilore/data/model/audio%20model/audio_model.dart';
import 'package:musilore/state/notifier/valuenotifiers.dart';

class PlayerFunctions {
  PlayerFunctions.internal();
  static final PlayerFunctions instance = PlayerFunctions.internal();
  factory PlayerFunctions() => instance;

  late final AudioPlayer player;

  int currentIndex = 0;
  List<AudioModel> audioModelList = [];

  Future<void> getPLayer() async {
    player = AudioPlayer();
    player.positionStream.listen((position) {
      playSliderDurationValue.value = position;
    });
    await player.setVolume(0.5);
    volumeNotifier.value = player.volume;
  }

  Future<void> playSong() async {
    final List<AudioSource> audioSourceList = [];

    for (AudioModel audioModel in audioModelList) {
      audioSourceList.add(AudioSource.uri(Uri(path: audioModel.path)));
    }

    final playList = ConcatenatingAudioSource(
      children: audioSourceList,
    );

    final Duration? maxDuration = await player.setAudioSource(
      playList,
      initialIndex: currentIndex,
      initialPosition: Duration.zero,
    );
    maxDurationValue.value = maxDuration;
    await player.play();
  }

  Future<void> pauseSong() async {
    await player.pause();
  }

  Future<void> resumeSong() async {
    await player.play();
    playSliderDurationValue.value = player.position;
  }

  Future<void> seekSong(Duration position) async {
    await player.seek(position);
  }

  Future<void> restartSong() async {
    await player.seek(Duration.zero);
    await player.play();
    playSliderDurationValue.value = Duration.zero;
    maxDurationValue.value = player.duration;
  }

  void playNextSong() async {
    await player.seekToNext();
    await player.play();
    playSliderDurationValue.value = Duration.zero;
    maxDurationValue.value = player.duration;
  }

  void playPrevSong() async {
    await player.seekToPrevious();
    await player.play();
    playSliderDurationValue.value = Duration.zero;
    maxDurationValue.value = player.duration;
  }

  Future<void> shuffleSong() async {
    List<AudioModel> shuffledList = [];
    await player.setShuffleModeEnabled(true);
    shuffledList.clear();
    for (int index in player.shuffleIndices!) {
      shuffledList.add(audioModelList[index]);
    }
    audioModelList = shuffledList;
  }

  Future<void> cancelShuffle() async {
    await player.setShuffleModeEnabled(false);
  }

  void stopSong() async {
    await player.stop();
  }

  Future<void> changeVolume(double volume) async {
    await player.setVolume(volume);
    volumeNotifier.value = player.volume;
  }
}
