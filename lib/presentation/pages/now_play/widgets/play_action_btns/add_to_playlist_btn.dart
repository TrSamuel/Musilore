import 'package:flutter/material.dart';
import 'package:musilore/presentation/pages/now_play/widgets/song_play_action_button.dart';
import 'package:musilore/presentation/widgets/add_playlist_dialog/show_playlist_add_dialoge.dart';
import 'package:musilore/state/notifier/play_list_notifier.dart';
import 'package:musilore/state/notifier/song_notifier.dart';
import 'package:musilore/state/notifier/theme_notifier.dart';
import 'package:provider/provider.dart';

class AddtoPlayListButton extends StatelessWidget {
  final bool darkThemeStatus;
  final Color secondaryColor;
  const AddtoPlayListButton({
    super.key,
    required this.darkThemeStatus,
    required this.secondaryColor,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer3<SongNotifier,ThemeModel,PlayListNotifier>(
      builder: (context, songNotifierData, themeData, playListNotifierData, child) => SongPlayActionButton(
        icon: Icons.playlist_add,
        action: () {
          showPlayListAddDialoge(
            context: context,
            playListNotifierData: playListNotifierData,
            themeData: themeData,
            secondaryColor: secondaryColor,
            audioModel: songNotifierData.currentPlayAudioModel!,
          );
        },
        darkThemeStatus: darkThemeStatus,
        secondaryColor: secondaryColor,
      ),
    );
  }
}
