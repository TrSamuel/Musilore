import 'package:flutter/material.dart';
import 'package:musilore/core/utils/color/colors.dart';
import 'package:musilore/core/utils/size/size.dart';
import 'package:musilore/core/utils/text/txt.dart';
import 'package:musilore/data/sources/db_functions.dart';
import 'package:musilore/data/model/audio%20model/audio_model.dart';
import 'package:musilore/function/player_fun.dart';
import 'package:musilore/presentation/widgets/snack_bar.dart';
import 'package:musilore/state/notifier/theme_notifier.dart';
import 'package:musilore/state/notifier/song_notifier.dart';
import 'package:provider/provider.dart';

class RecetnlyPlayedListTile extends StatelessWidget {
  final AudioModel audioModel;
  final int initailIndex;
  final List<String> pathList;
  const RecetnlyPlayedListTile({
    super.key,
    required this.audioModel,
    required this.initailIndex,
    required this.pathList,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer2<ThemeModel, SongNotifier>(
        builder: (context, themeData, songplayNotfierData, _) {
      final bool darkThemeStatus = themeData.darkThemeStatus;
      final Color secondaryColor = themeData.secondaryColor;
      return Card(
        color: darkThemeStatus ? primaryColor : primaryTextColor,
        shadowColor: secondaryColor,
        elevation: 5,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: BorderSide(width: 1, color: secondaryColor)),
        child: ListTile(
          onTap: () async {
            songplayNotfierData.viewMiniPlayer();
            songplayNotfierData.getCurrentSong(audioModel: audioModel);
            songplayNotfierData.resumeSong();
            PlayerFunctions.instance.playSong();
            Navigator.pushNamed(context, 'play-song-page');
            DbFunctions.instance.addToPlayListBox(
              audiomodelInstance: audioModel,
              playListName: 'Recently played',
              playListKey: 'recently-played-key',
            );
            themeData.changeSecondaryColor(imageData: audioModel.image);
          },
          hoverColor: secondaryColor,
          leading: Icon(
            Icons.history,
            color: darkThemeStatus ? primaryTextColor : primaryColor,
          ),
          title: Text(
            audioModel.title,
            style: TextStyle(
                color: themeData.darkThemeStatus
                    ? primaryTextColor
                    : primaryColor),
          ),
          subtitle: audioModel.artist != '<unknown>'
              ? Text(audioModel.artist)
              : const Text('unknown artist'),
          subtitleTextStyle:
              const TextStyle(fontFamily: textFontFamilyName, fontSize: h3Size),
          textColor: themeData.darkThemeStatus
              ? secondaryColor
              : primaryColor.withOpacity(0.7),
          titleTextStyle:
              const TextStyle(fontFamily: textFontFamilyName, fontSize: h2Size),
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
                        audiomodelInstance: audioModel,
                        playListKey: 'favorites-key',
                        playListName: 'Favorites',
                      )
                      .then(
                        (_) => {
                          songplayNotfierData.getFavoritesStatus(),
                          snackbarWidget(
                              text: 'Added to favorites',
                              context: context,
                              secondaryColor: secondaryColor),
                        },
                      );
                } else {}
              },
              child: Icon(
                Icons.more_vert,
                color:
                    themeData.darkThemeStatus ? primaryTextColor : primaryColor,
              ),
              itemBuilder: (context) => [
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
                  child: Text("Add to playlist"),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
