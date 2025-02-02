import 'package:flutter/material.dart';
import 'package:musilore/core/utils/color/colors.dart';
import 'package:musilore/core/utils/size/size.dart';
import 'package:musilore/core/utils/text/txt.dart';
import 'package:musilore/data/model/audio%20model/audio_model.dart';
import 'package:musilore/data/model/playlist%20model/audio_play_list_model.dart';
import 'package:musilore/data/sources/db_functions.dart';
import 'package:musilore/presentation/pages/create_update_playlist/create_or_update_playlist_page.dart';
import 'package:musilore/presentation/widgets/snack_bar.dart';
import 'package:musilore/state/notifier/play_list_notifier.dart';
import 'package:musilore/state/notifier/theme_notifier.dart';

class MoreOptionPLayList extends StatelessWidget {
  const MoreOptionPLayList({
    super.key,
    required this.playList,
    required this.isFavorites,
    required this.themeData, required this.playListNotifierData,
  });

  final AudioPlayListModel playList;
  final bool isFavorites;
  final ThemeModel themeData;
  final PlayListNotifier playListNotifierData;

  @override
  Widget build(BuildContext context) {
    return PopupMenuTheme(
      data: PopupMenuThemeData(
        textStyle: const TextStyle(
          color: primaryColor,
          fontFamily: textFontFamilyName,
          fontSize: h2Size,
        ),
        color: themeData.darkThemeStatus
            ? primaryTextColor
            : themeData.secondaryColor,
      ),
      child: PopupMenuButton<String>(
        onSelected: (value) async {
          if (value == 'Delete') {
            showDialog(
              context: context,
              builder: (alertDialogueContext) => AlertDialog(
                titleTextStyle: const TextStyle(
                  fontFamily: textFontFamilyName,
                  color: primaryColor,
                  fontSize: h2Size,
                  fontWeight: FontWeight.bold,
                ),
                title: const Text("Delete"),
                content: const Text("Do you want to delete this playlist?"),
                contentTextStyle: TextStyle(
                  fontFamily: textFontFamilyName,
                  color: primaryColor.withOpacity(0.7),
                  fontSize: h3Size,
                ),
                actions: [
                  YesButton(themeData: themeData, playList: playList, playListNotifierData: playListNotifierData),
                  const SizedBox(
                    width: 10,
                  ),
                  NoButton(themeData: themeData),
                  const SizedBox(
                    width: 10,
                  ),
                ],
              ),
            );
          } else if (value == 'Edit') {
            playListNotifierData.selectedSongsList.clear();
            for (AudioModel audiModel in playList.audioModelList) {
              playListNotifierData.addToSelectedSongs(audioModel: audiModel);
            }
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CreateOrUpdatePLayListScreen(
                  playListId: playList.playListId,
                  playListName: playList.playListName,
                  isFavorites: isFavorites,
                ),
              ),
            );
          }
        },
        position: PopupMenuPosition.under,
        icon: const Icon(
          Icons.more_vert,
          color: primaryColor,
        ),
        itemBuilder: (context) => [
          const PopupMenuItem(value: 'Edit', child: Text('Edit')),
          if (!isFavorites)
            const PopupMenuItem(value: 'Delete', child: Text('Delete'))
        ],
      ),
    );
  }
}

class NoButton extends StatelessWidget {
  const NoButton({
    super.key,
    required this.themeData,
  });

  final ThemeModel themeData;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          foregroundColor: primaryColor,
          backgroundColor: themeData.secondaryColor,
          textStyle: const TextStyle(
            fontFamily: textFontFamilyName,
            fontSize: h3Size,
          )),
      onPressed: () {
        Navigator.pop(context);
      },
      child: const Text("No"),
    );
  }
}

class YesButton extends StatelessWidget {
  const YesButton({
    super.key,
    required this.themeData,
    required this.playList,
    required this.playListNotifierData,
  });

  final ThemeModel themeData;
  final AudioPlayListModel playList;
  final PlayListNotifier playListNotifierData;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            foregroundColor: primaryColor,
            backgroundColor: themeData.secondaryColor,
            textStyle: const TextStyle(
              fontFamily: textFontFamilyName,
              fontSize: h3Size,
            )),
        onPressed: () async {
          await DbFunctions.instance
              .deletePlayList(
            playlistId: playList.playListId,
          )
              .then((_) {
            playListNotifierData.getPlayList();
            Navigator.pop(context);
            snackbarWidget(
              text: 'Playlist deleted',
              context: context,
              secondaryColor: themeData.secondaryColor,
            );
          });
        },
        child: const Text("Yes"));
  }
}
