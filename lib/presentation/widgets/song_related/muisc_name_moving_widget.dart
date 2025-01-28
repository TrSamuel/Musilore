import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';
import 'package:musilore/core/utils/color/colors.dart';
import 'package:musilore/core/utils/enum/song_play_enum.dart';
import 'package:musilore/core/utils/size/size.dart';
import 'package:musilore/core/utils/text/txt.dart';
import 'package:musilore/state/notifier/song_notifier.dart';
import 'package:musilore/state/notifier/theme_notifier.dart';
import 'package:provider/provider.dart';

class MusicNameMovingTextWidget extends StatelessWidget {
  const MusicNameMovingTextWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      height: 20,
      child: Consumer2<SongNotifier, ThemeModel>(
        builder: (context, songPLayNotifierData, themeModelData, _) =>
            songPLayNotifierData.songplayStatus == SongplayStatus.play
                ? Marquee(
                    blankSpace: songPLayNotifierData.currentPlayAudioModel!.title.length
                            .toDouble() *
                        2,
                    text: songPLayNotifierData.currentPlayAudioModel?.title ?? "",
                    style: TextStyle(
                      color: themeModelData.darkThemeStatus
                          ? primaryTextColor
                          : primaryColor,
                      fontSize: h3Size,
                      fontFamily: textFontFamilyName,
                    ),
                    velocity: 50,
                  )
                : Text(
                    songPLayNotifierData.currentPlayAudioModel?.title ?? "",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: themeModelData.darkThemeStatus
                          ? primaryTextColor
                          : primaryColor,
                      fontSize: h3Size,
                      fontFamily: textFontFamilyName,
                    ),
                  ),
      ),
    );
  }
}
