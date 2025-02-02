import 'package:flutter/material.dart';
import 'package:musilore/core/utils/color/colors.dart';
import 'package:musilore/core/utils/size/size.dart';
import 'package:musilore/core/utils/text/txt.dart';
import 'package:musilore/data/model/audio%20model/audio_model.dart';
import 'package:musilore/data/sources/db_functions.dart';
import 'package:musilore/presentation/widgets/snack_bar.dart';
import 'package:musilore/state/notifier/song_notifier.dart';
import 'package:musilore/state/notifier/theme_notifier.dart';

class MoreOptionButton extends StatelessWidget {
  const MoreOptionButton({
    super.key,
    required this.secondaryColor,
    required this.audioModel,
    required this.themeData, required this.songplayNotfierData,
  });

  final Color secondaryColor;
  final AudioModel audioModel;
  final ThemeModel themeData;
  final SongNotifier songplayNotfierData;

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
          color: themeData.darkThemeStatus ? primaryTextColor : primaryColor,
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
    );
  }
}
