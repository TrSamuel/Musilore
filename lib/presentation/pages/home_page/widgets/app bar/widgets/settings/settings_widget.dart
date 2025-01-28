import 'package:flutter/material.dart';
import 'package:musilore/core/utils/color/colors.dart';
import 'package:musilore/core/utils/size/size.dart';
import 'package:musilore/core/utils/text/txt.dart';
import 'package:musilore/presentation/pages/home_page/widgets/app%20bar/widgets/settings/widgets/sync_now_btn.dart';
import 'package:musilore/presentation/pages/home_page/widgets/app%20bar/widgets/settings/widgets/theme_changer_swich.dart';


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
        itemBuilder: (context) => [
          PopupMenuItem(
            child: ThemeChangerSwitch(
              darkThemeStatus: darkThemeStatus,
              secondaryColor: secondaryColor,
            ),
          ),
          const PopupMenuItem(
            child: SyncNowButton(),
          )
        ],
      ),
    );
  }
}

