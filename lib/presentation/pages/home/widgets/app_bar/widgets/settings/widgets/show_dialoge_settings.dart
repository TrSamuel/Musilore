import 'package:flutter/material.dart';
import 'package:musilore/core/utils/color/colors.dart';
import 'package:musilore/core/utils/size/size.dart';
import 'package:musilore/core/utils/text/txt.dart';

Future<dynamic> showDialogForSettings({
  required BuildContext context,
  required bool darkThemeStatus,
  required Color secondaryColor,
  required String title,
  required String contentTitle,
}) {
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      titleTextStyle: const TextStyle(
        fontFamily: textFontFamilyName,
        fontSize: h2Size,
        color: primaryColor,
      ),
      title: Text(title),
      content: Text(contentTitle),
      contentTextStyle: TextStyle(
          fontFamily: textFontFamilyName,
          fontSize: h3Size,
          color: primaryColor.withOpacity(0.8)),
      actions: [
        Center(
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                fixedSize: Size.fromWidth(
                  MediaQuery.sizeOf(context).width * 0.2,
                ),
                backgroundColor: darkThemeStatus
                    ? secondaryColor
                    : primaryTextColor.withOpacity(0.1),
                foregroundColor: primaryColor,
                textStyle: const TextStyle(
                  fontFamily: textFontFamilyName,
                  fontSize: h3Size,
                ),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Close")),
        ),
      ],
    ),
  );
}
