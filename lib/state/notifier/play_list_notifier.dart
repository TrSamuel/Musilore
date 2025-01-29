import 'package:flutter/material.dart';
import 'package:musilore/core/utils/text/txt.dart';
import 'package:musilore/data/sources/db_functions.dart';
import 'package:musilore/data/model/audio%20model/audio_model.dart';
import 'package:musilore/data/model/playlist%20model/audio_play_list_model.dart';

class PlayListNotifier extends ChangeNotifier {
  List<AudioPlayListModel> playListList = [];

  List<AudioModel> currentSelectedPlayListsongs = [];

  List<AudioModel> selectedSongsList = [];

  late int selectionRadioValue = 2;

  String selectedPlayListId = '';

  bool errorTextDropDown = false;

  void trueErrorTextDropDown() {
    errorTextDropDown = true;
    notifyListeners();
  }

  void falseErrorTextDropDown() {
    errorTextDropDown = false;
    notifyListeners();
  }

  void selectPlayList({required String id}) {
    selectedPlayListId = id;
    notifyListeners();
  }

  void initialSelectionRadioValue() {
    if (playListList.isNotEmpty) {
      selectionRadioValue = 1;
    } else {
      selectionRadioValue = 2;
    }
    selectedPlayListId = '';
    notifyListeners();
  }

  void changeSelectionRadioValue({required int value}) {
    selectionRadioValue = value;
    notifyListeners();
  }

  void addToSelectedSongs({required AudioModel audioModel}) {
    selectedSongsList
        .removeWhere((audioModelItem) => audioModelItem.id == audioModel.id);
    selectedSongsList.add(audioModel);
    notifyListeners();
  }

  void removefromSelectedSongs({required int id}) {
    selectedSongsList.removeWhere((audioModel) => audioModel.id == id);
    notifyListeners();
  }

  Future<void> getCurrentSelectedPlayListSongs(
      {required String playListId}) async {
    currentSelectedPlayListsongs = await DbFunctions.instance
        .getCurrentPlayListSongs(playListId: playListId);
    currentSelectedPlayListsongs =
        currentSelectedPlayListsongs.reversed.toList();
    notifyListeners();
  }

  Future<void> getPlayList() async {
    playListList = await DbFunctions.instance.getPlayList();
    if (sharedPreferences.getString(constRecentlyPlayedKey) != null) {
      playListList.removeWhere(
        (playListModel) =>
            playListModel.playListId ==
            sharedPreferences.getString(
              constRecentlyPlayedKey,
            ),
      );
    }
    playListList = playListList.reversed.toList();
    if (sharedPreferences.getString(constFavoritesKey) != null) {
      final temp = playListList.singleWhere((playList) =>
          playList.playListId ==
          sharedPreferences.getString(constFavoritesKey));
      for (var i = 0; i < playListList.length; i++) {
        if (playListList[i].playListId == temp.playListId) {
          for (var j = i; j > 0; j--) {
            playListList[j] = playListList[j - 1];
          }
          playListList[0] = temp;
          break;
        }
      }
    }

    notifyListeners();
  }
}
