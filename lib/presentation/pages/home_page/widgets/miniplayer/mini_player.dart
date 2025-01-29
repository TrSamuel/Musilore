// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:musilore/core/utils/color/colors.dart';
import 'package:musilore/presentation/pages/home_page/widgets/miniplayer/close_mini_player_button.dart';
import 'package:musilore/presentation/pages/home_page/widgets/miniplayer/full_screen_icon_btn.dart';
import 'package:musilore/presentation/pages/home_page/widgets/miniplayer/play_actions/mini_player_action.dart';
import 'package:musilore/presentation/widgets/song_related/muisc_name_moving_widget.dart';
import 'package:musilore/state/notifier/song_notifier.dart';
import 'package:musilore/state/notifier/theme_notifier.dart';
import 'package:provider/provider.dart';

class MiniPlayer extends StatelessWidget {
  const MiniPlayer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer2<ThemeModel, SongNotifier>(
      builder: (context, themeData, songPLayNotifierData, _) => Visibility(
        visible: songPLayNotifierData.miniPlayerViewStatus,
        child: Container(
          width: double.infinity,
          height: 100,
          decoration: BoxDecoration(
            color: themeData.darkThemeStatus
                ? primaryColor.withOpacity(0.9)
                : themeData.secondaryColor.withOpacity(0.8),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FullScreenIconButton(
                      darkThemeStatus: themeData.darkThemeStatus),
                  const MusicNameMovingTextWidget(),
                  const CloseMiniPLayerIconButton(),
                ],
              ),
              miniPlayerActions(songPLayNotifierData, themeData),
            ],
          ),
        ),
      ),
    );
  }



}
