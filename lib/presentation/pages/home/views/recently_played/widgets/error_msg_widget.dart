import 'package:flutter/material.dart';
import 'package:musilore/core/utils/color/colors.dart';
import 'package:musilore/core/utils/size/size.dart';
import 'package:musilore/core/utils/text/txt.dart';
import 'package:musilore/state/notifier/theme_notifier.dart';
import 'package:provider/provider.dart';

class ErrorMessageWidget extends StatelessWidget {
  const ErrorMessageWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Consumer<ThemeModel>(
        builder: (context, themeData, child) => Text(
          'No songs recently wateched',
          style: TextStyle(
            color: themeData.darkThemeStatus
                ? primaryTextColor
                : primaryColor,
            fontFamily: textFontFamilyName,
            fontSize: h3Size,
          ),
        ),
      ),
    );
  }
}

