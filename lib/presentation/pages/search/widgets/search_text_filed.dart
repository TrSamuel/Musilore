import 'package:flutter/material.dart';
import 'package:musilore/core/utils/color/colors.dart';
import 'package:musilore/core/utils/size/size.dart';
import 'package:musilore/core/utils/text/txt.dart';
import 'package:musilore/state/notifier/search_notifier.dart';
import 'package:musilore/state/notifier/theme_notifier.dart';
import 'package:provider/provider.dart';

class SearchTextField extends StatelessWidget {
  final ThemeModel newThemeData;
  const SearchTextField({
    super.key,
    required this.newThemeData,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      cursorColor: newThemeData.secondaryColor,
      style: TextStyle(
        color: newThemeData.darkThemeStatus ? primaryTextColor : primaryColor,
        fontFamily: textFontFamilyName,
        fontSize: h3Size,
      ),
      showCursor: true,
      decoration: InputDecoration(
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: newThemeData.secondaryColor),
        ),
        border: UnderlineInputBorder(
          borderSide: BorderSide(color: newThemeData.secondaryColor),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: newThemeData.secondaryColor),
        ),
        hintText: 'Seach songs...artists...',
        hintStyle: TextStyle(
          color: newThemeData.darkThemeStatus
              ? primaryTextColor
              : primaryColor.withOpacity(0.75),
        ),
      ),
      onChanged: (searchValue) async {
        final searChNotifierData =
            Provider.of<SearchNotifer>(context, listen: false);
        searChNotifierData.searchSongs(
          searchValue: searchValue,
        );
      },
    );
  }
}
