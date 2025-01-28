import 'package:flutter/material.dart';
import 'package:musilore/core/utils/enum/song_play_enum.dart';
import 'package:musilore/function/player_fun.dart';
import 'package:musilore/presentation/pages/now_play/widgets/song_play_action_button.dart';
import 'package:musilore/state/notifier/song_notifier.dart';
import 'package:provider/provider.dart';

class PlayOrPauseButton extends StatelessWidget {
  const PlayOrPauseButton({
    super.key,
    required this.darkThemeStatus,
    required this.secondaryColor,
  });

  final bool darkThemeStatus;
  final Color secondaryColor;

  @override
  Widget build(BuildContext context) {
    return Consumer<SongNotifier>(
      builder: (context, songNotifierData, child) => SongPlayActionButton(
        secondaryColor: secondaryColor,
        darkThemeStatus: darkThemeStatus,
        icon: songNotifierData.songplayStatus == SongplayStatus.pause
            ? Icons.play_arrow
            : Icons.pause,
        action: () {
           if (songNotifierData.songplayStatus == SongplayStatus.play) {
            PlayerFunctions.instance.pauseSong();
            songNotifierData.pauseSong();
          } else {
            PlayerFunctions.instance.resumeSong();
            songNotifierData.resumeSong();
          }
        },
      ),
    );
  }
}
