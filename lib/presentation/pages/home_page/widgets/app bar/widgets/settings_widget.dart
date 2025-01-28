import 'package:flutter/material.dart';
import 'package:musilore/core/utils/color/colors.dart';
import 'package:musilore/core/utils/size/size.dart';
import 'package:musilore/core/utils/text/txt.dart';
import 'package:musilore/state/notifier/song_notifier.dart';
import 'package:musilore/state/notifier/theme_notifier.dart';
import 'package:provider/provider.dart';

class SettingsWidget extends StatelessWidget {
  const SettingsWidget({
    super.key,
    required this.darkThemeStatus,
    required this.secondaryColor,
  });

  final bool darkThemeStatus;
  final Color secondaryColor;

  @override
  Widget build(BuildContext context) {
    return PopupMenuTheme(
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
                    Provider.of<SongNotifier>(context, listen: false)
                        .getSongs(context);
                  },
                  child: const Text("Sync now")),
            ))
          ],
        ));
  }
}