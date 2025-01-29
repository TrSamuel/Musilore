// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:musilore/core/utils/color/colors.dart';
import 'package:musilore/core/utils/size/size.dart';
import 'package:musilore/core/utils/text/txt.dart';
import 'package:musilore/presentation/pages/open_playlist/widgets/app_bar/widgets/app_bar_action.dart';
import 'package:musilore/state/notifier/play_list_notifier.dart';
import 'package:musilore/state/notifier/theme_notifier.dart';
import 'package:provider/provider.dart';

AppBar appbarForOpenPlayListPage({
  required BuildContext context,
  required String playlistName,
  required bool isFavorites,
  required String playListId,
}) {
  final themeData = context.watch<ThemeModel>();
  final playListNotifierData =
      Provider.of<PlayListNotifier>(context, listen: false);
  return AppBar(
    backgroundColor:
        themeData.darkThemeStatus ? primaryColor : primaryTextColor,
    foregroundColor:
        themeData.darkThemeStatus ? primaryTextColor : primaryColor,
    titleTextStyle: TextStyle(
      fontFamily: textFontFamilyName,
      fontSize: h1Size,
      color: themeData.darkThemeStatus ? primaryTextColor : primaryColor,
    ),
    title: Row(
      children: [
        const Icon(
          size: 30,
          Icons.playlist_play_outlined,
        ),
        const SizedBox(
          width: 10,
        ),
        Text(playlistName),
      ],
    ),
    leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(Icons.arrow_back_ios_new)),
    actions: [
      AppBarActionOpenPLayList(
          isFavorites: isFavorites,
          playListId: playListId,
          playlistName: playlistName,
          themeData: themeData,
          playListNotifierData: playListNotifierData),
    ],
  );
}

