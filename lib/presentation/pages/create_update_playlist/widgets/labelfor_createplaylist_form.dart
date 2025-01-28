import 'package:flutter/material.dart';
import 'package:musilore/core/utils/color/colors.dart';
import 'package:musilore/core/utils/size/size.dart';
import 'package:musilore/core/utils/text/txt.dart';
import 'package:musilore/state/notifier/theme_notifier.dart';

class LabelForCreatePLaylistForm extends StatelessWidget {
  final ThemeModel themeData;
  final String lableName;
  const LabelForCreatePLaylistForm({
    super.key,
    required this.themeData,
    required this.lableName,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      lableName,
      style: TextStyle(
        color: themeData.darkThemeStatus ? primaryTextColor : primaryColor,
        fontFamily: textFontFamilyName,
        fontSize: h3Size,
      ),
    );
  }
}
