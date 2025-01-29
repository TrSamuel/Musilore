import 'package:flutter/material.dart';
import 'package:musilore/core/utils/color/colors.dart';
import 'package:musilore/state/notifier/theme_notifier.dart';

class PlayListNameInputField extends StatelessWidget {
  const PlayListNameInputField({
    super.key,
    required this.isFavorites,
    required this.playlistNameController,
    required this.formKey,
    required this.themeData,
  });

  final bool? isFavorites;
  final TextEditingController playlistNameController;
  final GlobalKey<FormState> formKey;
  final ThemeModel themeData;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: (isFavorites != null && isFavorites == true) ? true : false,
      cursorColor: themeData.secondaryColor,
      controller: playlistNameController,
      style: TextStyle(
        color: themeData.darkThemeStatus ? primaryTextColor : primaryColor,
      ),
      decoration: InputDecoration(
        errorStyle: TextStyle(
            color: themeData.darkThemeStatus
                ? themeData.secondaryColor
                : primaryColor.withOpacity(0.75)),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 1,
            color: themeData.secondaryColor,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 1,
            color: themeData.secondaryColor,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 1,
            color: themeData.secondaryColor,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 1,
            color: themeData.secondaryColor,
          ),
        ),
      ),
      validator: (value) {
        value = value!.trim();
        if (value.isEmpty) {
          return 'This field cannot be empty';
        }
        return null;
      },
      onChanged: (value) {
        formKey.currentState?.validate();
      },
    );
  }
}
