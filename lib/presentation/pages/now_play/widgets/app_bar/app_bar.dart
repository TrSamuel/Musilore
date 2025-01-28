import 'package:flutter/material.dart';
import 'package:musilore/core/utils/color/colors.dart';
import 'package:musilore/core/utils/size/size.dart';
import 'package:musilore/core/utils/text/txt.dart';
import 'package:musilore/state/notifier/song_notifier.dart';
import 'package:musilore/state/notifier/theme_notifier.dart';
import 'package:provider/provider.dart';

AppBar appBarForPlayPage(ThemeModel themeData, BuildContext context) {
  return AppBar(
    leading: IconButton(
      color:
          themeData.darkThemeStatus ? themeData.secondaryColor : primaryColor,
      onPressed: () {
        Navigator.pop(context);
      },
      icon: const Icon(
        Icons.arrow_back_ios_new,
      ),
    ),
    backgroundColor:
        themeData.darkThemeStatus ? primaryColor : primaryTextColor,
    title:
        Consumer<SongNotifier>(builder: (context, songplayNotiferData, _) {
      return Text(songplayNotiferData.currentPlayAudioModel!.title);
    }),
    titleTextStyle: TextStyle(
      fontFamily: textFontFamilyName,
      fontSize: h1Size,
      color: themeData.darkThemeStatus ? primaryTextColor : primaryColor,
    ),
    foregroundColor:
        themeData.darkThemeStatus ? primaryTextColor : primaryColor,
  );
}
