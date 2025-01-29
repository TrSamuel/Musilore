import 'package:flutter/material.dart';
import 'package:musilore/core/utils/enum/song_play_enum.dart';
import 'package:musilore/function/player_fun.dart';
import 'package:musilore/presentation/pages/home_page/widgets/miniplayer/play_actions/widgets/mini_player_action_buttons.dart';
import 'package:musilore/state/notifier/song_notifier.dart';

class PlayPauseBtn extends StatelessWidget {
  final SongNotifier songPLayNotifierData;
  const PlayPauseBtn({
    super.key, required this.songPLayNotifierData,
  });

  @override
  Widget build(BuildContext context) {
    return MiniPLayerActionButtons(
      action: () {
        if (songPLayNotifierData.songplayStatus == SongplayStatus.restart) {
          songPLayNotifierData.resumeSong();
          PlayerFunctions.instance.restartSong();
        } else if (songPLayNotifierData.songplayStatus == SongplayStatus.play) {
          songPLayNotifierData.pauseSong();
          PlayerFunctions.instance.pauseSong();
        } else {
          songPLayNotifierData.resumeSong();
          PlayerFunctions.instance.resumeSong();
        }
      },
      icon: songPLayNotifierData.songplayStatus == SongplayStatus.pause ||
              songPLayNotifierData.songplayStatus == SongplayStatus.restart
          ? Icons.play_arrow
          : Icons.pause,
    );
  }
}
