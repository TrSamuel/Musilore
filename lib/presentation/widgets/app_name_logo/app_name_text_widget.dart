import 'package:flutter/material.dart';
import 'package:musilore/core/utils/color/colors.dart';
import 'package:musilore/core/utils/text/txt.dart';

class AppNameTextWidget extends StatelessWidget {
  final double fontSize;
  final bool newDarkThemeStatus;
  final Color secondaryColor;
  const AppNameTextWidget({
    super.key,
    required this.fontSize,
    required this.newDarkThemeStatus, required this.secondaryColor,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      "Musilore",
      style: TextStyle(
        color: newDarkThemeStatus ? primaryTextColor : primaryColor,
        shadows: [
          Shadow(color: secondaryColor, blurRadius: 40, offset: const Offset(0, 2))
        ],
        fontSize: fontSize,
        fontFamily: logoFontFamilyName,
      ),
    );
  }
}
