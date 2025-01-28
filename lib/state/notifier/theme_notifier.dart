import 'dart:typed_data';
import 'package:musilore/data/sources/db_functions.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:flutter/material.dart';

class ThemeModel extends ChangeNotifier {
  bool darkThemeStatus = true;
  Color secondaryColor = const Color.fromARGB(255, 170, 210, 180);

  void changetoDarkTheme() {
    darkThemeStatus = true;
    notifyListeners();
  }

  void changetowhiteTheme() {
    darkThemeStatus = false;
    notifyListeners();
  }

  Future<void> changeTheme() async {
    final bool? darkTheme = sharedPreferences.getBool('dark-theme');
    if (darkTheme == false) {
      await sharedPreferences.setBool('dark-theme', true);
      darkThemeStatus = true;
    } else {
      await sharedPreferences.setBool('dark-theme', false);
      darkThemeStatus = false;
    }
    notifyListeners();
  }

  void changeSecondaryColor({required Uint8List? imageData}) async {
    if (imageData == null) {
      secondaryColor = const Color.fromARGB(255, 170, 210, 180);
    } else {
      final MemoryImage imageProvider = MemoryImage(imageData);
      final PaletteGenerator paletteGenerator =
          await PaletteGenerator.fromImageProvider(imageProvider);

      final List<PaletteColor> validColors =
          paletteGenerator.paletteColors.where((color) {
        return color.color.computeLuminance() > 0.3;
      }).toList();

      if (validColors.isNotEmpty) {
        secondaryColor = validColors.first.color;
      } else {
        secondaryColor = const Color.fromARGB(255, 170, 210, 180);
      }
    }

    notifyListeners();
  }
}
