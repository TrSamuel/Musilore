import 'package:flutter/material.dart';
import 'package:musilore/core/utils/color/colors.dart';
import 'package:musilore/core/utils/secure/devemail.dart';
import 'package:musilore/core/utils/size/size.dart';
import 'package:musilore/core/utils/text/txt.dart';
import 'package:musilore/presentation/pages/home/widgets/app_bar/widgets/settings/widgets/show_dialoge_settings.dart';

class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({
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
            title: "Privacy Policy",
            contentTitle:
                "Musilore respects your privacy and is designed to work entirely offline. The app does not collect, store, or share any personal data or files. It only accesses your device’s storage to locate and play music files, and media controls are used solely for playback features like play/pause and shuffle. No information is shared with third parties, and Musilore is safe for users of all ages. For any questions, contact us at $mail.",
            context: context,
            darkThemeStatus: darkThemeStatus,
            secondaryColor: secondaryColor,
          );
        },
        child: const Text("Privacy Policy"));
  }
}
