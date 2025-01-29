import 'package:flutter/material.dart';
import 'package:musilore/core/utils/color/colors.dart';
import 'package:musilore/core/utils/size/size.dart';
import 'package:musilore/presentation/pages/now_play/widgets/app_bar/app_bar.dart';
import 'package:musilore/presentation/pages/now_play/widgets/music_container.dart';
import 'package:musilore/presentation/pages/now_play/widgets/play_slider.dart';
import 'package:musilore/presentation/pages/now_play/widgets/playsong_action_widget.dart';
import 'package:musilore/state/notifier/theme_notifier.dart';
import 'package:provider/provider.dart';

class PlaySongPage extends StatelessWidget {
  const PlaySongPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    const sizedBox = SizedBox(
      height: 25,
    );
    return SafeArea(
      child: Consumer<ThemeModel>(
        builder: (context, themeData, _) {
          return Scaffold(
            backgroundColor:
                themeData.darkThemeStatus ? primaryColor : primaryTextColor,
            appBar: appBarForPlayPage(themeData, context),
            body: SizedBox(
              width: fullsize(context: context).width,
              height: fullsize(context: context).height,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Padding(
                  padding: const EdgeInsets.only(top: 38),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      MusicContainer(
                        secondaryColor: themeData.secondaryColor,
                        darkTheme: themeData.darkThemeStatus,
                      ),
                      sizedBox,
                      PlaySlider(
                        darkThemeStatus: themeData.darkThemeStatus,
                        secondaryColor: themeData.secondaryColor,
                      ),
                      sizedBox,
                      SongPlayActionWidget(
                        secondaryColor: themeData.secondaryColor,
                        darkThemeStatus: themeData.darkThemeStatus,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
