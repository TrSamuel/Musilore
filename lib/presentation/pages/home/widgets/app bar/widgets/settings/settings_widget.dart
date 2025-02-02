import 'package:flutter/material.dart';
import 'package:musilore/core/utils/color/colors.dart';
import 'package:musilore/core/utils/secure/devemail.dart';
import 'package:musilore/core/utils/size/size.dart';
import 'package:musilore/core/utils/text/txt.dart';
import 'package:musilore/presentation/pages/home/widgets/app%20bar/widgets/settings/widgets/show_dialoge_settings.dart';
import 'package:musilore/presentation/pages/home/widgets/app%20bar/widgets/settings/widgets/sync_now_btn.dart';
import 'package:musilore/presentation/pages/home/widgets/app%20bar/widgets/settings/widgets/theme_changer_swich.dart';
import 'package:musilore/presentation/pages/home/widgets/app%20bar/widgets/settings/widgets/volume_adjuster/volume_adjuster.dart';

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
            child: VolumeAdjuster(darkThemeStatus: darkThemeStatus, secondaryColor: secondaryColor),
          ),
          PopupMenuItem(
            child: ThemeChangerSwitch(
              darkThemeStatus: darkThemeStatus,
              secondaryColor: secondaryColor,
            ),
          ),
          const PopupMenuItem(
            child: SyncMusic(),
          ),
          PopupMenuItem(
            child: TextButton(
                style: TextButton.styleFrom(
                    foregroundColor: primaryColor,
                    textStyle: const TextStyle(
                      fontFamily: textFontFamilyName,
                      fontSize: h3Size,
                    )),
                onPressed: () {
                  showDialogForSettings(
                    title: "Privacy Policy",
                    contentTitle:
                        "Musilore respects your privacy and is designed to work entirely offline. The app does not collect, store, or share any personal data or files. It only accesses your device’s storage to locate and play music files, and media controls are used solely for playback features like play/pause and shuffle. No information is shared with third parties, and Musilore is safe for users of all ages. For any questions, contact us at $mail.",
                    context: context,
                    darkThemeStatus: darkThemeStatus,
                    secondaryColor: secondaryColor,
                  );
                },
                child: const Text("Privacy Policy")),
          ),
          PopupMenuItem(
            child: TextButton(
                style: TextButton.styleFrom(
                    foregroundColor: primaryColor,
                    textStyle: const TextStyle(
                      fontFamily: textFontFamilyName,
                      fontSize: h3Size,
                    )),
                onPressed: () {
                  showDialogForSettings(
                    title: "About",
                    contentTitle:
                        "Musilore - Your Personal Music Player Musilore lets you play songs stored on your device with ease. Create playlists, add favorites, search for tracks, and enjoy dynamic color themes that match your music. With shuffle, play/pause, and next/prev controls, it’s music made simple and stylish!",
                    context: context,
                    darkThemeStatus: darkThemeStatus,
                    secondaryColor: secondaryColor,
                  );
                },
                child: const Text("About")),
          ),
        ],
      ),
    );
  }
}

