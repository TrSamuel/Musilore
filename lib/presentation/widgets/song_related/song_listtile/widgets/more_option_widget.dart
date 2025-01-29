import 'package:flutter/material.dart';
import 'package:musilore/core/utils/color/colors.dart';
import 'package:musilore/core/utils/size/size.dart';
import 'package:musilore/core/utils/text/txt.dart';
import 'package:musilore/data/model/audio%20model/audio_model.dart';
import 'package:musilore/data/sources/db_functions.dart';
import 'package:musilore/presentation/widgets/add_playlist_dialog/show_playlist_add_dialoge.dart';
import 'package:musilore/presentation/widgets/snack_bar.dart';
import 'package:musilore/state/notifier/play_list_notifier.dart';
import 'package:musilore/state/notifier/theme_notifier.dart';

class MoreOptionWidget extends StatelessWidget {
  const MoreOptionWidget({
    super.key,
    required this.secondaryColor,
    required this.audioModelList,
    required this.initialIndex,
    required this.themeData, required this.playListNotifierData,
  });

  final Color secondaryColor;
  final List<AudioModel> audioModelList;
  final int initialIndex;
  final ThemeModel themeData;
  final PlayListNotifier playListNotifierData;

  @override
  Widget build(BuildContext context) {
    return PopupMenuTheme(
      data: PopupMenuThemeData(
          color: themeData.darkThemeStatus ? primaryTextColor : secondaryColor),
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
          color: themeData.darkThemeStatus ? primaryTextColor : primaryColor,
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
    );
  }
}
