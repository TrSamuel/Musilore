import 'package:flutter/material.dart';
import 'package:musilore/data/sources/db_functions.dart';
import 'package:musilore/data/model/audio%20model/audio_model.dart';

class SearchNotifer extends ChangeNotifier {
  List<AudioModel> searchedSongsList = [];

  Future<void> searchSongs({required String searchValue}) async {
    searchedSongsList.clear();
    searchedSongsList =
        await DbFunctions.instance.searchSongs(songName: searchValue);
    notifyListeners();
  }
}
