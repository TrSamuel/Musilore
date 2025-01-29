import 'package:flutter/material.dart';
import 'package:musilore/core/utils/color/colors.dart';
import 'package:musilore/core/utils/size/size.dart';
import 'package:musilore/core/utils/text/txt.dart';
import 'package:musilore/state/notifier/play_list_notifier.dart';
import 'package:musilore/state/notifier/theme_notifier.dart';

class SongsSelectorContainer extends StatelessWidget {
  const SongsSelectorContainer({
    super.key,
    required this.playListName,
    required this.themeData, required this.playListNotifierData,
  });

  final String? playListName;
  final ThemeModel themeData;
  final PlayListNotifier playListNotifierData;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 200,
      decoration: BoxDecoration(
          border: Border.all(color: themeData.secondaryColor, width: 1)),
      child: playListNotifierData.selectedSongsList.isEmpty
          ? Center(
              child: Text(
                playListName != null
                    ? "No songs available"
                    : 'No songs selected',
                style: TextStyle(
                    fontFamily: textFontFamilyName,
                    fontSize: h3Size,
                    color: themeData.darkThemeStatus
                        ? primaryTextColor
                        : primaryColor),
              ),
            )
          : ListView.builder(
              itemCount: playListNotifierData.selectedSongsList.length,
              itemBuilder: (context, index) {
                final orderedList =
                    playListNotifierData.selectedSongsList.reversed.toList();
                return Card(
                  color: themeData.darkThemeStatus
                      ? primaryColor
                      : primaryTextColor,
                  shadowColor: themeData.secondaryColor,
                  shape: LinearBorder.bottom(
                      side: BorderSide(
                          style: BorderStyle.solid,
                          width: 0.5,
                          color: themeData.secondaryColor)),
                  child: ListTile(
                    textColor: themeData.darkThemeStatus
                        ? primaryTextColor
                        : primaryColor,
                    titleTextStyle: const TextStyle(
                      fontFamily: textFontFamilyName,
                      fontSize: h3Size,
                    ),
                    title: Text(
                      orderedList[index].title,
                    ),
                    trailing: IconButton(
                        color: themeData.secondaryColor,
                        onPressed: () {
                          playListNotifierData.removefromSelectedSongs(
                            id: orderedList[index].id,
                          );
                        },
                        icon: const Icon(Icons.delete)),
                  ),
                );
              },
            ),
    );
  }
}
