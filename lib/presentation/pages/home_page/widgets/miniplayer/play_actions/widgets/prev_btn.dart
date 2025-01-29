import 'package:flutter/material.dart';
import 'package:musilore/data/sources/db_functions.dart';
import 'package:musilore/function/player_fun.dart';
import 'package:musilore/presentation/pages/home_page/widgets/miniplayer/play_actions/widgets/mini_player_action_buttons.dart';
import 'package:musilore/state/notifier/song_notifier.dart';
import 'package:musilore/state/notifier/theme_notifier.dart';
import 'package:provider/provider.dart';

class PrevButton extends StatelessWidget {
  const PrevButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MiniPLayerActionButtons(
        action: () async {
          if (PlayerFunctions.instance.currentIndex > 0) {
            PlayerFunctions.instance.currentIndex =
                PlayerFunctions
                        .instance.player.previousIndex ??
                    PlayerFunctions.instance.currentIndex;

            PlayerFunctions.instance.playPrevSong();
            final songNotifierData =
                Provider.of<SongNotifier>(context,
                    listen: false);

            songNotifierData.getCurrentSong(
              audioModel:
                  PlayerFunctions.instance.audioModelList[
                      PlayerFunctions.instance.currentIndex],
            );
            Provider.of<ThemeModel>(context, listen: false)
                .changeSecondaryColor(
              imageData: PlayerFunctions
                  .instance
                  .audioModelList[
                      PlayerFunctions.instance.currentIndex]
                  .image,
            );
            await DbFunctions.instance.addToPlayListBox(
              audiomodelInstance:
                  PlayerFunctions.instance.audioModelList[
                      PlayerFunctions.instance.currentIndex],
              playListName: 'Recently played',
              playListKey: 'recently-played-key',
            );

            songNotifierData.getRecentlySongs();
          }
        },
        icon: Icons.skip_previous);
  }
}

