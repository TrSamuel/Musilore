import 'package:flutter/material.dart';
import 'package:musilore/core/utils/enum/song_play_enum.dart';
import 'package:musilore/data/sources/db_functions.dart';
import 'package:musilore/data/model/audio%20model/audio_model.dart';
import 'package:musilore/function/player_fun.dart';

class SongNotifier extends ChangeNotifier {
  SongplayStatus songplayStatus = SongplayStatus.pause;

  bool miniPlayerViewStatus = false;

  bool isFavorites = false;

  bool isShuffeled = false;

  AudioModel? currentPlayAudioModel;

  List<AudioModel> songsList = [];

  List<AudioModel> recentlySongs = [];

  void getSongs(BuildContext context) async {
    await DbFunctions.instance.fetchSongsFromStorage(context: context);
    songsList = await DbFunctions.instance.getSongsFromBox();
    notifyListeners();
  }

  void getCurrentSong({required AudioModel audioModel}) async {
    currentPlayAudioModel = audioModel;
    resumeSong();
    getFavoritesStatus();

    notifyListeners();
  }

  void getFavoritesStatus() async {
    isFavorites = await DbFunctions.instance.isFavorites(id: currentPlayAudioModel!.id);
    notifyListeners();
  }

  void pauseSong() {
    songplayStatus = SongplayStatus.pause;
    notifyListeners();
  }

  void resumeSong() {
    songplayStatus = SongplayStatus.play;
    notifyListeners();
  }

  Future<void> shuffleSong() async {
    isShuffeled = !isShuffeled;
    if (isShuffeled) {
      await PlayerFunctions.instance.shuffleSong();
    } else {
      await PlayerFunctions.instance.cancelShuffle();
    }
    notifyListeners();
  }

  Future<void> getRecentlySongs() async {
    recentlySongs = await DbFunctions.instance.getRecentlySongs();
    notifyListeners();
  }

  void viewMiniPlayer() {
    miniPlayerViewStatus = true;
    notifyListeners();
  }

  void closeMiniPlayer() {
    miniPlayerViewStatus = false;
    notifyListeners();
  }
}
