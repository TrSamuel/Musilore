import 'package:flutter/material.dart';
import 'package:musilore/core/utils/color/colors.dart';
import 'package:musilore/core/utils/size/size.dart';
import 'package:musilore/core/utils/text/txt.dart';

snackbarWidget(
    {required String text,
    required BuildContext context,
    required Color secondaryColor}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      duration: const Duration(seconds: 2),
      backgroundColor: secondaryColor,
      content: Text(
        text,
        style: const TextStyle(
          fontFamily: textFontFamilyName,
          fontSize: h3Size,
          color: primaryColor,
        ),
      ),
    ),
  );
}
