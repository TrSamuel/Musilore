import 'package:flutter/material.dart';
import 'package:musilore/core/utils/color/colors.dart';
import 'package:musilore/core/utils/size/size.dart';
import 'package:musilore/presentation/pages/home/widgets/app_bar/tab_bar_widget.dart';
import 'package:musilore/presentation/pages/home/widgets/app_bar/widgets/search/search_btn.dart';
import 'package:musilore/presentation/pages/home/widgets/app_bar/widgets/settings/settings_widget.dart';
import 'package:musilore/presentation/widgets/app_name_logo/app_name_text_widget.dart';
import 'package:musilore/state/notifier/theme_notifier.dart';
import 'package:provider/provider.dart';

AppBar appBarHome(BuildContext context) {
  final themeData = Provider.of<ThemeModel>(context);
  final bool darkThemeStatus = themeData.darkThemeStatus;
  final Color secondaryColor = themeData.secondaryColor;
  return AppBar(
    backgroundColor: darkThemeStatus ? primaryColor : primaryTextColor,
    foregroundColor: darkThemeStatus ? primaryTextColor : primaryColor,
    title: AppNameTextWidget(
        secondaryColor: secondaryColor,
        fontSize: h1Size,
        newDarkThemeStatus: darkThemeStatus),
    actions: [
      const SearchButtonWidget(),
      SettingsWidget(
        darkThemeStatus: darkThemeStatus,
        secondaryColor: secondaryColor,
      )
    ],
    bottom: tabBarWidget(themeData: themeData),
  );
}




