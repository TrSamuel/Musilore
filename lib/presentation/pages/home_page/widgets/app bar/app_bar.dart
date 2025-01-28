import 'package:flutter/material.dart';
import 'package:musilore/core/utils/color/colors.dart';
import 'package:musilore/core/utils/size/size.dart';
import 'package:musilore/core/utils/text/txt.dart';
import 'package:musilore/presentation/pages/home_page/widgets/app%20bar/app_bar_action_button.dart';
import 'package:musilore/presentation/pages/home_page/widgets/app%20bar/tab_bar_widget.dart';
import 'package:musilore/presentation/widgets/app_name_logo/app_name_text_widget.dart';
import 'package:musilore/state/notifier/search_notifier.dart';
import 'package:musilore/state/notifier/song_notifier.dart';
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
      AppBarActionButton(
        icon: Icons.search,
        action: () {
          Provider.of<SearchNotifer>(context, listen: false)
              .searchedSongsList
              .clear();
          Navigator.pushNamed(context, 'search-page');
        },
      ),
      PopupMenuTheme(
          data: PopupMenuThemeData(
            position: PopupMenuPosition.over,
            textStyle: const TextStyle(
              color: primaryColor,
              fontFamily: textFontFamilyName,
              fontSize: h3Size,
            ),
            color: darkThemeStatus ? primaryTextColor : secondaryColor,
          ),
          child: PopupMenuButton(
            icon: const Icon(Icons.settings),
            itemBuilder: (popUpMenuContext) => [
              PopupMenuItem(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Dark theme'),
                    Consumer<ThemeModel>(
                      builder: (context, themeData, _) => Switch(
                        trackColor: MaterialStatePropertyAll(
                          darkThemeStatus
                              ? secondaryColor.withOpacity(0.5)
                              : primaryTextColor.withOpacity(0.5),
                        ),
                        thumbColor: darkThemeStatus
                            ? MaterialStatePropertyAll(secondaryColor)
                            : const MaterialStatePropertyAll(primaryColor),
                        value: darkThemeStatus,
                        onChanged: (_) {
                          themeData.changeTheme();
                          Navigator.pop(popUpMenuContext);
                        },
                      ),
                    )
                  ],
                ),
              ),
              PopupMenuItem(
                  child: Center(
                child: TextButton(
                    style: TextButton.styleFrom(
                      foregroundColor: primaryColor,
                      textStyle: const TextStyle(
                        color: primaryColor,
                        fontFamily: textFontFamilyName,
                        fontSize: h3Size,
                      ),
                    ),
                    onPressed: () {
                      Provider.of<SongNotifier>(context,listen: false).getSongs(context);
                    },
                    child: const Text("Sync now")),
              ))
            ],
          ))
    ],
    bottom: tabBarWidget(themeData: themeData),
  );
}
