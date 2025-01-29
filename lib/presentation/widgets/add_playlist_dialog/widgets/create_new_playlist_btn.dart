import 'package:flutter/material.dart';
import 'package:musilore/core/utils/color/colors.dart';
import 'package:musilore/core/utils/size/size.dart';
import 'package:musilore/core/utils/text/txt.dart';
import 'package:musilore/state/notifier/play_list_notifier.dart';

class CreateNewPlayListBtn extends StatelessWidget {
  final PlayListNotifier playListNotifier;
  const CreateNewPlayListBtn({
    super.key, required this.playListNotifier,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        fixedSize: Size.fromWidth(
          MediaQuery.sizeOf(context).width * 0.6,
        ),
        foregroundColor: primaryColor,
        textStyle: const TextStyle(
          fontFamily: textFontFamilyName,
          fontSize: h2Size,
          fontWeight: FontWeight.bold,
        ),
      ),
      child: const Text(
        "Create new playList",
        style: TextStyle(
          fontFamily: textFontFamilyName,
          fontSize: h3Size,
          color: primaryColor,
        ),
      ),
      onPressed: () {
        playListNotifier.changeSelectionRadioValue(
          value: 2,
        );
      },
    );
  }
}

