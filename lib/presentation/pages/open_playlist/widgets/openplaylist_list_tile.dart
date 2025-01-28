import 'package:flutter/material.dart';
import 'package:musilore/core/utils/color/colors.dart';
import 'package:musilore/core/utils/size/size.dart';
import 'package:musilore/core/utils/text/txt.dart';
import 'package:musilore/data/sources/db_functions.dart';
import 'package:musilore/data/model/audio%20model/audio_model.dart';
import 'package:musilore/function/player_fun.dart';
import 'package:musilore/presentation/widgets/snack_bar.dart';
import 'package:musilore/state/notifier/play_list_notifier.dart';
import 'package:musilore/state/notifier/song_notifier.dart';
import 'package:musilore/state/notifier/theme_notifier.dart';
import 'package:provider/provider.dart';

class OpenPLayListListTile extends StatelessWidget {
  final AudioModel audioModel;
  final int initialndex;
  final bool favoriteStatus;
  final String playListId;
  const OpenPLayListListTile({
    super.key,
    required this.audioModel,
    required this.initialndex,
    required this.favoriteStatus,
    required this.playListId,
  });

  @override
  Widget build(BuildContext context) {
    final playListNotifierData =
        Provider.of<PlayListNotifier>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Consumer2<ThemeModel, SongNotifier>(
        builder: (context, themeData, songNotifierData, _) => Card(
          color: themeData.darkThemeStatus ? primaryColor : primaryTextColor,
          shadowColor: themeData.secondaryColor,
          elevation: 5,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
              side: BorderSide(width: 1, color: themeData.secondaryColor)),
          child: ListTile(
            onTap: () async {
              PlayerFunctions.instance.audioModelList.clear();
              PlayerFunctions.instance.audioModelList
                  .addAll(playListNotifierData.currentSelectedPlayListsongs);
              songNotifierData.viewMiniPlayer();
              songNotifierData.getCurrentSong(
                audioModel: audioModel,
              );
              songNotifierData.resumeSong();
              PlayerFunctions.instance.currentIndex = initialndex;
              PlayerFunctions.instance.playSong();

              Navigator.pushNamed(context, 'play-song-page');
              await DbFunctions.instance.addToPlayListBox(
                audiomodelInstance: audioModel,
                playListName: 'Recently played',
                playListKey: 'recently-played-key',
              );

              songNotifierData.getRecentlySongs();
              themeData.changeSecondaryColor(imageData: audioModel.image);
            },
            hoverColor: themeData.secondaryColor,
            leading: Icon(
              Icons.music_note,
              color:
                  themeData.darkThemeStatus ? primaryTextColor : primaryColor,
            ),
            titleTextStyle: const TextStyle(
                fontFamily: textFontFamilyName, fontSize: h2Size),
            title: Text(
              audioModel.title,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: TextStyle(
                  color: themeData.darkThemeStatus
                      ? primaryTextColor
                      : primaryColor),
            ),
            subtitle: audioModel.artist != '<unknown>'
                ? Text(
                    audioModel.artist,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  )
                : const Text('unknown artist'),
            subtitleTextStyle: const TextStyle(
                fontFamily: textFontFamilyName, fontSize: h3Size),
            textColor: themeData.darkThemeStatus
                ? themeData.secondaryColor
                : primaryColor.withOpacity(0.7),
            trailing: favoriteStatus
                ? TextButton(
                    style: TextButton.styleFrom(
                      foregroundColor: themeData.darkThemeStatus
                          ? primaryTextColor
                          : primaryColor,
                    ),
                    child: const Text(
                      "Unfavorite",
                      style: TextStyle(
                        fontFamily: textFontFamilyName,
                        fontSize: h3Size,
                      ),
                    ),
                    onPressed: () async {
                      await DbFunctions.instance
                          .removeFromFavorites(
                            id: audioModel.id,
                          )
                          .then(
                            (_) => snackbarWidget(
                              text: 'Removed from favorites',
                              context: context,
                              secondaryColor: themeData.secondaryColor,
                            ),
                          );
                      playListNotifierData.getCurrentSelectedPlayListSongs(
                        playListId: playListId,
                      );
                    },
                  )
                : null,
          ),
        ),
      ),
    );
  }
}
