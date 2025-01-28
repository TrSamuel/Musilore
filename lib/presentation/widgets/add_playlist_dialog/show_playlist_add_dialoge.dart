import 'package:flutter/material.dart';
import 'package:musilore/core/utils/color/colors.dart';
import 'package:musilore/core/utils/size/size.dart';
import 'package:musilore/core/utils/text/txt.dart';
import 'package:musilore/data/model/audio%20model/audio_model.dart';
import 'package:musilore/data/model/playlist%20model/audio_play_list_model.dart';
import 'package:musilore/data/sources/db_functions.dart';
import 'package:musilore/presentation/widgets/add_playlist_dialog/widgets/create_new_playlistwidget.dart';
import 'package:musilore/presentation/widgets/add_playlist_dialog/widgets/select_playlistwidget.dart';
import 'package:musilore/state/notifier/play_list_notifier.dart';
import 'package:musilore/state/notifier/theme_notifier.dart';
import 'package:provider/provider.dart';

Future<dynamic> showPlayListAddDialoge({
  required BuildContext context,
  required PlayListNotifier playListNotifierData,
  required ThemeModel themeData,
  required Color secondaryColor,
  required AudioModel audioModel,
}) {
  return showDialog(
    context: context,
    builder: (context) => WillPopScope(
      onWillPop: () async {
        playListNotifierData.initialSelectionRadioValue();
        playListNotifierData.falseErrorTextDropDown();
        return true;
      },
      child: AlertDialog(
        backgroundColor: themeData.darkThemeStatus
            ? primaryTextColor
            : themeData.secondaryColor,
        content: RadioTheme(
          data: const RadioThemeData(
              fillColor: MaterialStatePropertyAll(primaryColor)),
          child: Consumer<PlayListNotifier>(
              builder: (context, playListNotifier, _) {
            final List<AudioPlayListModel> playLists =
                List.from(playListNotifier.playListList);
            playLists.removeWhere(
              (playList) =>
                  playList.playListId ==
                  sharedPreferences.getString(constFavoritesKey),
            );
            return SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (playLists.isNotEmpty)
                    TextButton(
                      style: TextButton.styleFrom(
                        fixedSize: Size.fromWidth(
                          MediaQuery.sizeOf(context).width * 0.6,
                        ),
                        foregroundColor: primaryColor,
                        textStyle: const TextStyle(
                          fontFamily: textFontFamilyName,
                          fontSize: h2Size,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      child: const Text(
                        "Select playList",
                        style: TextStyle(
                          fontFamily: textFontFamilyName,
                          fontSize: h3Size,
                          color: primaryColor,
                        ),
                      ),
                      onPressed: () {
                        playListNotifier.changeSelectionRadioValue(
                          value: 1,
                        );
                      },
                    ),
                  if (playListNotifier.selectionRadioValue == 1 &&
                      playLists.isNotEmpty)
                    SelectPlayListWidget(
                      audioModel: audioModel,
                      darkThemeStatus: themeData.darkThemeStatus,
                      playLists: playLists,
                      secondaryColor: secondaryColor,
                    ),
                  if (playLists.isNotEmpty)
                    const Divider(
                      color: primaryColor,
                    ),
                  TextButton(
                    style: TextButton.styleFrom(
                      fixedSize: Size.fromWidth(
                        MediaQuery.sizeOf(context).width * 0.6,
                      ),
                      foregroundColor: primaryColor,
                      textStyle: const TextStyle(
                        fontFamily: textFontFamilyName,
                        fontSize: h2Size,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    child: const Text(
                      "Create new playList",
                      style: TextStyle(
                        fontFamily: textFontFamilyName,
                        fontSize: h3Size,
                        color: primaryColor,
                      ),
                    ),
                    onPressed: () {
                      playListNotifier.changeSelectionRadioValue(
                        value: 2,
                      );
                    },
                  ),
                  if (playListNotifier.selectionRadioValue == 2)
                    CreateNewPLayListWIdget(
                      audioModel: audioModel,
                      themeData: themeData,
                      secondaryColor: secondaryColor,
                    ),
                  Padding(
                    padding: const EdgeInsets.only(top: 18),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          fixedSize: Size.fromWidth(
                            MediaQuery.sizeOf(context).width * 0.2,
                          ),
                          backgroundColor: themeData.darkThemeStatus
                              ? secondaryColor
                              : primaryTextColor.withOpacity(0.1),
                          foregroundColor: primaryColor,
                          textStyle: const TextStyle(
                            fontFamily: textFontFamilyName,
                            fontSize: h3Size,
                          ),
                        ),
                        onPressed: () {
                          playListNotifierData.initialSelectionRadioValue();
                          playListNotifierData.falseErrorTextDropDown();
                          Navigator.pop(context);
                        },
                        child: const Text("Close")),
                  )
                ],
              ),
            );
          }),
        ),
      ),
    ),
  );
}
