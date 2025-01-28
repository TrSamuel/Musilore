import 'package:flutter/material.dart';
import 'package:musilore/data/sources/db_functions.dart';
import 'package:musilore/function/player_fun.dart';
import 'package:musilore/presentation/pages/now_play/widgets/song_play_action_button.dart';
import 'package:musilore/state/notifier/song_notifier.dart';
import 'package:musilore/state/notifier/theme_notifier.dart';
import 'package:provider/provider.dart';

class ShuffleButton extends StatelessWidget {
  const ShuffleButton({
    super.key,
    required this.darkThemeStatus,
    required this.secondaryColor,
  });

  final bool darkThemeStatus;
  final Color secondaryColor;

  @override
  Widget build(BuildContext context) {
    return Consumer2<SongNotifier, ThemeModel>(
      builder: (context, songNotifierData, themeData, _) =>
          SongPlayActionButton(
        darkThemeStatus: darkThemeStatus,
        icon: songNotifierData.isShuffeled
            ? Icons.shuffle_on_rounded
            : Icons.shuffle,
        action: () async {
          await songNotifierData.shuffleSong();
          if (!songNotifierData.isShuffeled) {
            songNotifierData.getCurrentSong(
              audioModel: PlayerFunctions.instance.audioModelList[0],
            );
            PlayerFunctions.instance.currentIndex = 0;
            await  PlayerFunctions.instance.playSong();
            
            songNotifierData.resumeSong();
            await DbFunctions.instance.addToPlayListBox(
              audiomodelInstance: PlayerFunctions.instance.audioModelList[0],
              playListName: 'Recently played',
              playListKey: 'recently-played-key',
            );

            songNotifierData.getRecentlySongs();
            themeData.changeSecondaryColor(
                imageData: PlayerFunctions.instance.audioModelList[0].image);
          }
        },
        secondaryColor: secondaryColor,
      ),
    );
  }
}
