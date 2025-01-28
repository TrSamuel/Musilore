import 'package:flutter/material.dart';
import 'package:musilore/presentation/pages/now_play/widgets/play_action_btns/add_favorites_btn.dart';
import 'package:musilore/presentation/pages/now_play/widgets/play_action_btns/add_to_playlist_btn.dart';
import 'package:musilore/presentation/pages/now_play/widgets/play_action_btns/next_btn.dart';
import 'package:musilore/presentation/pages/now_play/widgets/play_action_btns/play_or_pause_btn.dart';
import 'package:musilore/presentation/pages/now_play/widgets/play_action_btns/prev_btn.dart';
import 'package:musilore/presentation/pages/now_play/widgets/play_action_btns/restart_button.dart';
import 'package:musilore/presentation/pages/now_play/widgets/play_action_btns/shuffle_btn.dart';
import 'package:musilore/presentation/widgets/song_related/muisc_name_moving_widget.dart';

class SongPlayActionWidget extends StatelessWidget {
  final bool darkThemeStatus;
  final Color secondaryColor;
   const SongPlayActionWidget({
    super.key,
    required this.darkThemeStatus,
    required this.secondaryColor,
  });

  @override
  Widget build(BuildContext context) {
    const sizedBox = SizedBox(
      height: 25,
    );
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ShuffleButton(
                  darkThemeStatus: darkThemeStatus,
                  secondaryColor: secondaryColor),
              PreviousButton(
                darkThemeStatus: darkThemeStatus,
                secondaryColor: secondaryColor,
              ),
              PlayOrPauseButton(
                darkThemeStatus: darkThemeStatus,
                secondaryColor: secondaryColor,
              ),
              NextButton(
                  darkThemeStatus: darkThemeStatus,
                  secondaryColor: secondaryColor),
              RestartzButton(
                  darkThemeStatus: darkThemeStatus,
                  secondaryColor: secondaryColor),
            ],
          ),
        ),
        sizedBox,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AddtoFavoriteButton(
                darkThemeStatus: darkThemeStatus,
                secondaryColor: secondaryColor,
              ),
              const MusicNameMovingTextWidget(),
              AddtoPlayListButton(
                darkThemeStatus: darkThemeStatus,
                secondaryColor: secondaryColor,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
