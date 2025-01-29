import 'package:flutter/material.dart';
import 'package:musilore/core/utils/color/colors.dart';
import 'package:musilore/core/utils/size/size.dart';
import 'package:musilore/core/utils/text/txt.dart';
import 'package:musilore/data/model/audio%20model/audio_model.dart';
import 'package:musilore/data/sources/db_functions.dart';
import 'package:musilore/presentation/pages/create_update_playlist/create_or_update_playlist_page.dart';
import 'package:musilore/presentation/widgets/snack_bar.dart';
import 'package:musilore/state/notifier/play_list_notifier.dart';
import 'package:musilore/state/notifier/theme_notifier.dart';

class AppBarActionOpenPLayList extends StatelessWidget {
  final String playListId;
  final String playlistName;
  final bool isFavorites;
  const AppBarActionOpenPLayList({
    super.key,
    required this.themeData,
    required this.playListNotifierData,
    required this.playListId,
    required this.playlistName,
    required this.isFavorites,
  });

  final ThemeModel themeData;
  final PlayListNotifier playListNotifierData;

  @override
  Widget build(BuildContext context) {
    return PopupMenuTheme(
      data: PopupMenuThemeData(
          color: themeData.secondaryColor,
          textStyle: const TextStyle(
            color: primaryColor,
            fontFamily: textFontFamilyName,
            fontSize: h3Size,
          )),
      child: PopupMenuButton<String>(
        icon: const Icon(Icons.more_vert),
        onSelected: (value) async {
          if (value == 'Edit') {
            playListNotifierData.selectedSongsList.clear();
            for (AudioModel audiModel
                in playListNotifierData.currentSelectedPlayListsongs) {
              playListNotifierData.addToSelectedSongs(audioModel: audiModel);
            }
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CreateOrUpdatePLayListScreen(
                  playListId: playListId,
                  playListName: playlistName,
                  isFavorites: isFavorites,
                ),
              ),
            );
          } else if (value == 'Delete') {
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
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          foregroundColor: primaryColor,
                          backgroundColor: themeData.secondaryColor,
                          textStyle: const TextStyle(
                            fontFamily: textFontFamilyName,
                            fontSize: h3Size,
                          )),
                      onPressed: () async {
                        await DbFunctions.instance
                            .deletePlayList(playlistId: playListId)
                            .then(
                          (_) {
                            playListNotifierData.getPlayList();
                            snackbarWidget(
                              text: 'Playlist deleted',
                              context: context,
                              secondaryColor: themeData.secondaryColor,
                            );
                            Navigator.pop(alertDialogueContext);
                            Navigator.pop(context);
                          },
                        );
                      },
                      child: const Text("Yes")),
                  const SizedBox(
                    width: 10,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        foregroundColor: primaryColor,
                        backgroundColor: themeData.secondaryColor,
                        textStyle: const TextStyle(
                          fontFamily: textFontFamilyName,
                          fontSize: h3Size,
                        )),
                    onPressed: () {
                      Navigator.pop(alertDialogueContext);
                    },
                    child: const Text("No"),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                ],
              ),
            );
          }
        },
        itemBuilder: (BuildContext context) {
          return [
            const PopupMenuItem(
              value: 'Edit',
              child: Text(
                'Edit playlist',
              ),
            ),
            if (!isFavorites)
              const PopupMenuItem(
                value: 'Delete',
                child: Text(
                  'Delete playlist',
                ),
              ),
          ];
        },
      ),
    );
  }
}
