import 'package:flutter/material.dart';
import 'package:musilore/data/sources/db_functions.dart';
import 'package:musilore/data/model/audio%20model/audio_model.dart';

class SearchNotifer extends ChangeNotifier {
  List<AudioModel> searchedSongsList = [];
  bool emptyListStatus = false;

  Future<void> searchSongs({required String searchValue}) async {
    searchedSongsList.clear();
    searchedSongsList =
        await DbFunctions.instance.searchSongs(songName: searchValue);
    if (searchedSongsList.isEmpty&&searchValue.trim()!='') {
      emptyListStatus = true;
    } else {
      emptyListStatus = false;
    }
    notifyListeners();
  }
}
