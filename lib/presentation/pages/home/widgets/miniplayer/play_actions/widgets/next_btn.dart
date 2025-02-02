import 'package:flutter/material.dart';
import 'package:musilore/data/sources/db_functions.dart';
import 'package:musilore/function/player_fun.dart';
import 'package:musilore/presentation/pages/home/widgets/miniplayer/play_actions/widgets/mini_player_action_buttons.dart';
import 'package:musilore/state/notifier/song_notifier.dart';
import 'package:musilore/state/notifier/theme_notifier.dart';
import 'package:provider/provider.dart';

class NextBtn extends StatelessWidget {
  const NextBtn({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MiniPLayerActionButtons(
        action: () async {
          final instance = PlayerFunctions.instance;
          final songNotifierData = Provider.of<SongNotifier>(
              context,
              listen: false);
          final themeData =
              Provider.of<ThemeModel>(context, listen: false);
          if (instance.currentIndex <
              instance.audioModelList.length - 1) {
            instance.currentIndex =
                instance.player.nextIndex ??
                    instance.currentIndex;
            instance.playNextSong();

            songNotifierData.getCurrentSong(
              audioModel: PlayerFunctions.instance
                  .audioModelList[instance.currentIndex],
            );

            themeData.changeSecondaryColor(
              imageData: PlayerFunctions
                  .instance
                  .audioModelList[instance.currentIndex]
                  .image,
            );
            await DbFunctions.instance.addToPlayListBox(
              audiomodelInstance: PlayerFunctions.instance
                  .audioModelList[instance.currentIndex],
              playListName: 'Recently played',
              playListKey: 'recently-played-key',
            );

            songNotifierData.getRecentlySongs();
          } else if (instance.currentIndex ==
              instance.audioModelList.length - 1) {
            songNotifierData.getCurrentSong(
              audioModel: instance.audioModelList[0],
            );
            instance.currentIndex = 0;
            instance.playSong();

            songNotifierData.resumeSong();
            DbFunctions.instance
                .addToPlayListBox(
                  audiomodelInstance:
                      instance.audioModelList[0],
                  playListName: 'Recently played',
                  playListKey: 'recently-played-key',
                )
                .then((_) =>
                    {songNotifierData.getRecentlySongs()});

            themeData.changeSecondaryColor(
                imageData: instance.audioModelList[0].image);
          }
        },
        icon: Icons.skip_next);
  }
}
