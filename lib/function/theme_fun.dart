
import 'package:flutter/material.dart';
import 'package:musilore/data/sources/db_functions.dart';
import 'package:musilore/state/notifier/theme_notifier.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';




class ThemeChanger {
  ThemeChanger.internal();
  static final ThemeChanger instance = ThemeChanger.internal();
  factory ThemeChanger() => instance;

  Future<void> getSharedPreferencesInstance(context) async {
    sharedPreferences = await SharedPreferences.getInstance();
    await setTheme(context);
  }

  Future<void> setTheme(BuildContext context) async {
  final bool? darkTheme =sharedPreferences.getBool('dark-theme');
  final darkThemeModel = Provider.of<ThemeModel>(context, listen: false);

  if (darkTheme == null) {
    await sharedPreferences.setBool('dark-theme', true);
    darkThemeModel.changetoDarkTheme();
  } else if (darkTheme) {
    darkThemeModel.changetoDarkTheme();
  } else {
    darkThemeModel.changetowhiteTheme();
  }
}

 
}
