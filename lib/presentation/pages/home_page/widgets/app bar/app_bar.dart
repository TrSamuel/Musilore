import 'package:flutter/material.dart';
import 'package:musilore/core/utils/color/colors.dart';
import 'package:musilore/core/utils/size/size.dart';
import 'package:musilore/presentation/pages/home_page/widgets/app%20bar/app_bar_action_button.dart';
import 'package:musilore/presentation/pages/home_page/widgets/app%20bar/tab_bar_widget.dart';
import 'package:musilore/presentation/pages/home_page/widgets/app%20bar/widgets/settings_widget.dart';
import 'package:musilore/presentation/widgets/app_name_logo/app_name_text_widget.dart';
import 'package:musilore/state/notifier/search_notifier.dart';
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

class SearchButtonWidget extends StatelessWidget {
  const SearchButtonWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBarActionButton(
      icon: Icons.search,
      action: () {
        Provider.of<SearchNotifer>(context, listen: false)
            .searchedSongsList
            .clear();
        Navigator.pushNamed(context, 'search-page');
      },
    );
  }
}


