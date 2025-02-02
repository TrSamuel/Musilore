// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:musilore/core/utils/color/colors.dart';
import 'package:musilore/data/sources/db_functions.dart';
import 'package:musilore/function/player_fun.dart';
import 'package:musilore/function/theme_fun.dart';
import 'package:musilore/presentation/widgets/app_name_logo/app_logo.dart';
import 'package:musilore/state/notifier/play_list_notifier.dart';
import 'package:musilore/state/notifier/song_notifier.dart';
import 'package:musilore/state/notifier/theme_notifier.dart';
import 'package:provider/provider.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    initialSetUp();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> initialSetUp() async {
    await ThemeChanger.instance.getSharedPreferencesInstance(context);
    await DbFunctions.instance.setUpAdapter();
    await DbFunctions.instance.openaudioBox();
    await PlayerFunctions.instance.getPLayer();
    await DbFunctions.instance.openPlayListbox();
    
    Provider.of<PlayListNotifier>(context, listen: false).getPlayList();
    Provider.of<PlayListNotifier>(context, listen: false).initialSelectionRadioValue();
    Provider.of<SongNotifier>(context, listen: false).getRecentlySongs();
    Future.delayed(
      const Duration(seconds: 1),
      () => movtoHomePage(),
     
    );
    
    
    Provider.of<SongNotifier>(context, listen: false).getSongs(context);
  }

  void movtoHomePage() {
    Navigator.pushReplacementNamed(context, 'home-page');
    
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeModel>(
      builder: (context, themeData, _) => Scaffold(
        backgroundColor:
            themeData.darkThemeStatus ? primaryColor : primaryTextColor,
        body: Center(
          child: AppLogo(
            width: 0.75,
            darkThemeStatus: themeData.darkThemeStatus,
            secondaryColor: themeData.secondaryColor,
          ),
        ),
      ),
    );
  }
}
