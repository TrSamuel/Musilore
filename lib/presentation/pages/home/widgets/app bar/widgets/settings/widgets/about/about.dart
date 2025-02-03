import 'package:flutter/material.dart';
import 'package:musilore/core/utils/color/colors.dart';
import 'package:musilore/core/utils/size/size.dart';
import 'package:musilore/core/utils/text/txt.dart';
import 'package:musilore/presentation/pages/home/widgets/app%20bar/widgets/settings/widgets/show_dialoge_settings.dart';

class About extends StatelessWidget {
  const About({
    super.key,
    required this.darkThemeStatus,
    required this.secondaryColor,
  });

  final bool darkThemeStatus;
  final Color secondaryColor;

  @override
  Widget build(BuildContext context) {
    return TextButton(
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
        child: const Text("About"));
  }
}
