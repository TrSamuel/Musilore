import 'package:flutter/material.dart';
import 'package:musilore/function/player_fun.dart';
import 'package:musilore/presentation/pages/now_play/widgets/song_play_action_button.dart';
import 'package:musilore/state/notifier/song_notifier.dart';
import 'package:provider/provider.dart';

class RestartzButton extends StatelessWidget {
  const RestartzButton({
    super.key,
    required this.darkThemeStatus,
    required this.secondaryColor,
  });

  final bool darkThemeStatus;
  final Color secondaryColor;

  @override
  Widget build(BuildContext context) {
    final songNotifierData = Provider.of<SongNotifier>(context);
    return SongPlayActionButton(
      secondaryColor: secondaryColor,
      icon: Icons.restart_alt,
      darkThemeStatus: darkThemeStatus,
      action: () {
        PlayerFunctions.instance.restartSong();
        songNotifierData.resumeSong();
      },
    );
  }
}
