import 'package:flutter/material.dart';
import 'package:musilore/core/utils/color/colors.dart';
import 'package:musilore/presentation/pages/search/widgets/search_text_filed.dart';
import 'package:musilore/state/notifier/theme_notifier.dart';

AppBar  appBar(ThemeModel themeData, BuildContext context) {
  return AppBar(
    backgroundColor:
        themeData.darkThemeStatus ? primaryColor : primaryTextColor,
    leading: IconButton(
        color: themeData.darkThemeStatus ? themeData.secondaryColor : primaryColor,
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(Icons.arrow_back_ios_new)),
    title: SearchTextField(newThemeData: themeData),
  );
}
