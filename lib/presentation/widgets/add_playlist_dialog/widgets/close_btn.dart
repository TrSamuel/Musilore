import 'package:flutter/material.dart';
import 'package:musilore/core/utils/color/colors.dart';
import 'package:musilore/core/utils/size/size.dart';
import 'package:musilore/core/utils/text/txt.dart';
import 'package:musilore/state/notifier/play_list_notifier.dart';
import 'package:musilore/state/notifier/theme_notifier.dart';

class CloseButton extends StatelessWidget {
  final ThemeModel themeData;
  final Color secondaryColor;
  final PlayListNotifier playListNotifierData;
  const CloseButton({
    super.key,
    required this.themeData,
    required this.secondaryColor,
    required this.playListNotifierData,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 18),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            fixedSize: Size.fromWidth(
              MediaQuery.sizeOf(context).width * 0.2,
            ),
            backgroundColor: themeData.darkThemeStatus
                ? secondaryColor
                : primaryTextColor.withOpacity(0.1),
            foregroundColor: primaryColor,
            textStyle: const TextStyle(
              fontFamily: textFontFamilyName,
              fontSize: h3Size,
            ),
          ),
          onPressed: () {
            playListNotifierData.initialSelectionRadioValue();
            playListNotifierData.falseErrorTextDropDown();
            Navigator.pop(context);
          },
          child: const Text("Close")),
    );
  }
}

