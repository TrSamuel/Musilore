// ignore_for_file: use_build_context_synchronously

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:musilore/core/utils/text/txt.dart';
import 'package:musilore/data/model/audio%20model/audio_model.dart';
import 'package:musilore/data/model/playlist%20model/audio_play_list_model.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:shared_preferences/shared_preferences.dart';

late LazyBox<AudioModel> audioBox;

late LazyBox<AudioPlayListModel> playlistBox;

late final SharedPreferences sharedPreferences;

class DbFunctions {
  DbFunctions.internal();
  static DbFunctions instance = DbFunctions.internal();
  factory DbFunctions() {
    return instance;
  }
//
//
//
//
//
//
//
// method for setup adapters
  Future<void> setUpAdapter() async {
    await Hive.initFlutter();
    if (!Hive.isAdapterRegistered(AudioModelAdapter().typeId) ||
        !Hive.isAdapterRegistered(AudioPlayListModelAdapter().typeId)) {
      // register audiomodel adapter
      Hive.registerAdapter(AudioModelAdapter());
      // register playlistmodel adapter
      Hive.registerAdapter(AudioPlayListModelAdapter());
    }
  }

//
//
//--------------------AUDIO BOX METHODS BEGINS------------------------------------------------
//
// method for open the box for audiomodel
  Future<void> openaudioBox() async {
    audioBox = await Hive.openLazyBox<AudioModel>(audioboxName);
  }

//
//
// method to add songs to audiobox after fetching from storage
  Future<void> addSongs(AudioModel audioModelInstance) async {
    // put into audiobox ,  song.id as a key
    await audioBox.put(audioModelInstance.id, audioModelInstance);
  }

//
//
// method for check song exists or not using song id
  Future<bool> checkSongExists({required int songId}) async {
    return audioBox.containsKey(songId);
  }

//
//
// method for fetch songs from storage
  Future<void> fetchSongsFromStorage({required BuildContext context}) async {
    // create a instance for onAudioQuery
    final OnAudioQuery audioQuery = OnAudioQuery();

    bool hasPermission = await audioQuery.checkAndRequest();

    // check storage access permission
    if (hasPermission) {
      // if has permission , then fetching songs from storage to list.
      List<SongModel> songs = await audioQuery.querySongs (
        sortType: null,
        orderType: OrderType.DESC_OR_GREATER,
        uriType: UriType.EXTERNAL,
        ignoreCase: true,
      );
     
      songs = songs.where((song) => song.fileExtension == "mp3").toList();
      
       // check song is empty or not
      if (songs.isNotEmpty) {
        // fetching each songs
        for (var song in songs) {
          // calling the method to check the song is already added to audiobox
          final songExists = await checkSongExists(songId: song.id);

          if (!songExists) {
            // fetching image of a song
            final Uint8List? artwork =
                await audioQuery.queryArtwork(song.id, ArtworkType.AUDIO);

            // creating audiomodel instance
            final songIntance = AudioModel(
              id: song.id,
              title: song.title,
              artist: song.artist!,
              image: artwork,
              path: song.data,
            );

            // calling the method to add song into box
            await addSongs(songIntance);
          }
        }
      }
    } else {
      // shows message if doesn't have permission
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Permission denied')));
    }
  }

//
//
// method for fetching songs from audiobox to show in app
  Future<List<AudioModel>> getSongsFromBox() async {
    final List<AudioModel> audioModelList = [];

    // fetching each key from audiobox for accessing the song
    for (var key in audioBox.keys) {
      // fetching song using this key
      final AudioModel? song = await audioBox.get(key);

      if (song != null) {
        // added to list if song is not null
        audioModelList.add(song);
      }
    }
    return audioModelList;
  }

//
//
// method for search songs
  Future<List<AudioModel>> searchSongs({required String songName}) async {
    final List<AudioModel> songsList = [];
    if (songName.trim().isNotEmpty) {
      for (var key in audioBox.keys) {
        final AudioModel? audioModel = await audioBox.get(key);
        if (audioModel != null) {
          if (audioModel.title.trim().toLowerCase().startsWith(
                songName.trim().toLowerCase(),
              )) {
            songsList.add(audioModel);
          }
        }
      }
    }
    return songsList;
  }

//
//--------------------AUDIO BOX METHODS ENDS--------------------------------------------------
//
//
//
//
//
//
//--------------------PLAYLIST BOX METHODS BEGINS--------------------------------------------------
//
// method for open the box for playlist
  Future<void> openPlayListbox() async {
    playlistBox = await Hive.openLazyBox<AudioPlayListModel>(playListBOxName);
  }

// method for create new playlist
  Future<void> createOrUpdatejPlayList({
    String? playListId,
    required String playListName,
    required List<AudioModel> listAudioModel,
  }) async {
    final List<AudioModel> audioModelList = [];

    for (var audioModel in listAudioModel) {
      audioModelList.add(audioModel);
    }
    playListId ??= DateTime.now().microsecondsSinceEpoch.toString();
    final AudioPlayListModel newPlayListModel = AudioPlayListModel(
      playListId: playListId,
      playListName: playListName,
      audioModelList: audioModelList,
    );

    await playlistBox.put(playListId, newPlayListModel);
  }
//
//

// method for delete playlist
  Future<void> deletePlayList({
    required String playlistId,
  }) async {
    await playlistBox.delete(playlistId);
  }

//
//
  Future<List<AudioPlayListModel>> getPlayList() async {
    final List<AudioPlayListModel> playlistList = [];
    for (var key in playlistBox.keys) {
      final AudioPlayListModel? playlist = await playlistBox.get(key);
      playlistList.add(playlist!);
    }
    return playlistList;
  }

//method for add songs to playlist
  Future<void> addToPlayListBox({
    required AudioModel audiomodelInstance,
    String? playListKey,
    String? playListId,
    String? playListName,
  }) async {
    if (playListKey != null) {
      // get the key from shared preferences
      String? playListId = sharedPreferences.getString(playListKey);

      if (playListId == null) {
        playListId = DateTime.now().millisecondsSinceEpoch.toString();

        // set value as current time stamp
        await sharedPreferences.setString(playListKey, playListId);

        //create a new playlistmodel
        final AudioPlayListModel playListModel = AudioPlayListModel(
          playListId: playListId,
          playListName: playListName!,
          audioModelList: [audiomodelInstance],
        );

        //save to database
        await playlistBox.put(playListId, playListModel);
      } else {
        // fetch existing playlistmodel
        final AudioPlayListModel? existPlayListModel =
            await playlistBox.get(playListId);

        //Remove existing audiomodel in the list of audimodelist
        existPlayListModel!.audioModelList.removeWhere(
            (existAudioModel) => existAudioModel.id == audiomodelInstance.id);

        // update the audiomodel list
        existPlayListModel.audioModelList.add(audiomodelInstance);

        // save to playlistbox
        await playlistBox.put(playListId, existPlayListModel);
      }
    } else {
      // fetch existing playlistmodel
      final AudioPlayListModel? existPlayListModel =
          await playlistBox.get(playListId);

      if (existPlayListModel != null) {
        // remove existing audiomodel from audiomodellist of playlist
        existPlayListModel.audioModelList.removeWhere(
            (AudioModel audioModel) => audioModel.id == audiomodelInstance.id);

        // updating the audiomodellist
        existPlayListModel.audioModelList.add(audiomodelInstance);

        // save to playlistbox
        await playlistBox.put(playListId, existPlayListModel);
      } else {
        // create new playlistmodel
        final newPlaylistModel = AudioPlayListModel(
          playListId: DateTime.now().millisecondsSinceEpoch.toString(),
          playListName: playListName!,
          audioModelList: [audiomodelInstance],
        );

        // save to playlistbox
        await playlistBox.put(playListId, newPlaylistModel);
      }
    }
  }
//
//

  Future<List<AudioModel>> getCurrentPlayListSongs(
      {required String playListId}) async {
    final List<AudioModel> audioModelList = [];

    final AudioPlayListModel? audioPlayListModel =
        await playlistBox.get(playListId);

    audioModelList.addAll(audioPlayListModel!.audioModelList);
    return audioModelList;
  }

//
//
//method for get recently played songs
  Future<List<AudioModel>> getRecentlySongs() async {
    // get the key from shared preferences
    String? recentlyPayedKey =
        sharedPreferences.getString(constRecentlyPlayedKey);

    //create a empty list of audiomodel list
    final List<AudioModel> audioModelList = [];

    // check key is null or not
    if (recentlyPayedKey != null) {
      // fetch recently played model
      final AudioPlayListModel? recentlyPlayedModel =
          await playlistBox.get(recentlyPayedKey);

      //check model is null or not
      if (recentlyPlayedModel != null) {
        // add songs to audiomodel list
        audioModelList.addAll(recentlyPlayedModel.audioModelList.reversed);
      }
    }
    return audioModelList;
  }

//
//
// method for add songs to favorites
  Future<void> removeFromFavorites({required int id}) async {
    // get key from sharedpreferences
    String? favoritesKey = sharedPreferences.getString(constFavoritesKey);

    // get existing favoiteslistmodel
    final AudioPlayListModel? existsfavoritesListModel =
        await playlistBox.get(favoritesKey);

    //Remove existing audiomodel from favorites
    existsfavoritesListModel!.audioModelList
        .removeWhere((existAudioModel) => existAudioModel.id == id);

    // update the favoties playlist model
    final AudioPlayListModel favoritesListModel = AudioPlayListModel(
      playListId: favoritesKey!,
      playListName: "Favorites",
      audioModelList: existsfavoritesListModel.audioModelList,
    );

    // save to database
    await playlistBox.put(favoritesKey, favoritesListModel);
  }

//
//
// method for check isFavorites
  Future<bool> isFavorites({required int id}) async {
    // get key from sharedpreferences
    String? favoritesKey = sharedPreferences.getString(constFavoritesKey);

    if (favoritesKey != null) {
      // fetch favoritesmodel
      final AudioPlayListModel? favoritesListModel =
          await playlistBox.get(favoritesKey);

      // get favorite status for audiomodel
      final bool status = favoritesListModel!.audioModelList
          .any((AudioModel existAudioModel) => existAudioModel.id == id);

      return status;
    }
    return false;
  }
//
//--------------------PLAYLIST BOX METHODS ENDS--------------------------------------------------
//
//
}
