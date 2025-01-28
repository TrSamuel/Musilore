import 'package:flutter/material.dart';
import 'package:musilore/core/utils/color/colors.dart';
import 'package:musilore/core/utils/size/size.dart';
import 'package:musilore/core/utils/text/txt.dart';
import 'package:musilore/state/notifier/theme_notifier.dart';

TabBar tabBarWidget({required ThemeModel themeData}) {
  return TabBar(
      isScrollable: true,
      labelPadding: const EdgeInsets.symmetric(horizontal: 25),
      labelColor: themeData.darkThemeStatus ? primaryTextColor : primaryColor,
      unselectedLabelColor: themeData.darkThemeStatus
          ? primaryTextColor.withOpacity(0.7)
          : primaryColor.withOpacity(0.7),
      labelStyle: const TextStyle(
        fontFamily: textFontFamilyName,
        fontWeight: FontWeight.bold,
        fontSize: h2Size,
      ),
      indicatorColor: themeData.secondaryColor,
      tabs: const [
        Tab(
          text: 'Songs',
        ),
        Tab(
          text: 'Recently played',
        ),
        Tab(
          text: 'Playlist',
        ),
      ]);
}
