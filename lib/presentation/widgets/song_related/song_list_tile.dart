// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:musilore/core/utils/color/colors.dart';
import 'package:musilore/core/utils/size/size.dart';
import 'package:musilore/core/utils/text/txt.dart';
import 'package:musilore/data/sources/db_functions.dart';
import 'package:musilore/data/model/audio%20model/audio_model.dart';
import 'package:musilore/function/player_fun.dart';
import 'package:musilore/presentation/widgets/add_playlist_dialog/show_playlist_add_dialoge.dart';
import 'package:musilore/presentation/widgets/snack_bar.dart';
import 'package:musilore/state/notifier/play_list_notifier.dart';
import 'package:musilore/state/notifier/song_notifier.dart';
import 'package:musilore/state/notifier/theme_notifier.dart';
import 'package:provider/provider.dart';

class SongListTile extends StatelessWidget {
  final IconData icon;
  final bool searchKeyboardShowStatus;
  final int initialIndex;
  final List<AudioModel> audioModelList;
  const SongListTile({
    super.key,
    required this.icon,
    this.searchKeyboardShowStatus = false,
    required this.initialIndex,
    required this.audioModelList,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer2<ThemeModel, PlayListNotifier>(
      builder: (context, themeData, playListNotifierData, _) {
        final Color secondaryColor = themeData.secondaryColor;

        return Card(
          color: themeData.darkThemeStatus ? primaryColor : primaryTextColor,
          shadowColor: secondaryColor,
          elevation: 5,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
              side: BorderSide(width: 1, color: secondaryColor)),
          child: ListTile(
            onTap: () async {
              PlayerFunctions.instance.audioModelList.clear();
              PlayerFunctions.instance.audioModelList.addAll(audioModelList);
              final songNotifierData =
                  Provider.of<SongNotifier>(context, listen: false);
              songNotifierData.viewMiniPlayer();
              songNotifierData.getCurrentSong(
                audioModel: audioModelList[initialIndex],
              );
              songNotifierData.resumeSong();
              PlayerFunctions.instance.currentIndex = initialIndex;
              PlayerFunctions.instance.playSong();
              if (searchKeyboardShowStatus) {
                FocusScope.of(context).unfocus();
              }
              await DbFunctions.instance.addToPlayListBox(
                audiomodelInstance: audioModelList[initialIndex],
                playListName: 'Recently played',
                playListKey: 'recently-played-key',
              );

              songNotifierData.getRecentlySongs();
              themeData.changeSecondaryColor(
                  imageData: audioModelList[initialIndex].image);

              Navigator.pushNamed(context, 'play-song-page');
            },
            hoverColor: secondaryColor,
            leading: Icon(
              icon,
              color:
                  themeData.darkThemeStatus ? primaryTextColor : primaryColor,
            ),
            titleTextStyle: const TextStyle(
                fontFamily: textFontFamilyName, fontSize: h2Size),
            title: Text(
              audioModelList[initialIndex].title,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              softWrap: false,
              style: TextStyle(
                  overflow: TextOverflow.fade,
                  color: themeData.darkThemeStatus
                      ? primaryTextColor
                      : primaryColor),
            ),
            subtitle: audioModelList[initialIndex].artist != '<unknown>'
                ? Text(
                    audioModelList[initialIndex].artist,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  )
                : const Text('unknown artist'),
            subtitleTextStyle: const TextStyle(
                fontFamily: textFontFamilyName, fontSize: h3Size),
            textColor: themeData.darkThemeStatus
                ? secondaryColor
                : primaryColor.withOpacity(0.7),
            trailing: PopupMenuTheme(
              data: PopupMenuThemeData(
                  color: themeData.darkThemeStatus
                      ? primaryTextColor
                      : secondaryColor),
              child: PopupMenuButton(
                onSelected: (String value) async {
                  if (value == 'add-to-favorites') {
                    await DbFunctions.instance
                        .addToPlayListBox(
                          audiomodelInstance: audioModelList[initialIndex],
                          playListKey: 'favorites-key',
                          playListName: 'Favorites',
                        )
                        .then(
                          (_) => {
                            playListNotifierData.getPlayList(),
                            snackbarWidget(
                                text: 'Added to favorites',
                                context: context,
                                secondaryColor: secondaryColor)
                          },
                        );
                  } else {
                    showPlayListAddDialoge(
                      context: context,
                      playListNotifierData: playListNotifierData,
                      themeData: themeData,
                      secondaryColor: secondaryColor,
                      audioModel: audioModelList[initialIndex],
                    );
                    playListNotifierData.initialSelectionRadioValue();
                  }
                },
                child: Icon(
                  Icons.more_vert,
                  color: themeData.darkThemeStatus
                      ? primaryTextColor
                      : primaryColor,
                ),
                itemBuilder: (popUpMenucontext) => [
                  const PopupMenuItem(
                    value: 'add-to-favorites',
                    textStyle: TextStyle(
                      color: primaryColor,
                      fontFamily: textFontFamilyName,
                      fontSize: h3Size,
                    ),
                    child: Text("Add to favorites"),
                  ),
                  const PopupMenuItem(
                      value: 'add-to-playlist',
                      textStyle: TextStyle(
                        color: primaryColor,
                        fontFamily: textFontFamilyName,
                        fontSize: h3Size,
                      ),
                      child: Text('Add to playlist')),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
