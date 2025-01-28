import 'package:flutter/material.dart';
import 'package:musilore/core/utils/color/colors.dart';
import 'package:musilore/data/sources/db_functions.dart';
import 'package:musilore/presentation/pages/now_play/widgets/song_play_action_button.dart';
import 'package:musilore/presentation/widgets/snack_bar.dart';
import 'package:musilore/state/notifier/play_list_notifier.dart';
import 'package:musilore/state/notifier/song_notifier.dart';
import 'package:provider/provider.dart';

class AddtoFavoriteButton extends StatelessWidget {
  const AddtoFavoriteButton({
    super.key,
    required this.darkThemeStatus,
    required this.secondaryColor,
  });

  final bool darkThemeStatus;
  final Color secondaryColor;

  @override
  Widget build(BuildContext context) {
    return Consumer2<SongNotifier, PlayListNotifier>(
      builder: (context, songPlayNotifierData, playListNotifierData, _) =>
          SongPlayActionButton(
        darkThemeStatus: darkThemeStatus,
        secondaryColor: secondaryColor,
        color: darkThemeStatus ? primaryTextColor : primaryColor,
        icon: songPlayNotifierData.isFavorites
            ? Icons.favorite
            : Icons.favorite_border,
        action: () async {
          if (!songPlayNotifierData.isFavorites) {
            await DbFunctions.instance
                .addToPlayListBox(
                    playListKey: 'favorites-key',
                    playListName: 'Favorites',
                    audiomodelInstance: songPlayNotifierData.currentPlayAudioModel!)
                .then(
                  (_) => snackbarWidget(
                    text: 'Added to favorites',
                    context: context,
                    secondaryColor: secondaryColor,
                  ),
                );
          } else {
            await DbFunctions.instance
                .removeFromFavorites(
                  id: songPlayNotifierData.currentPlayAudioModel!.id,
                )
                .then(
                  (_) => snackbarWidget(
                    text: 'Removed from favorites',
                    context: context,
                    secondaryColor: secondaryColor,
                  ),
                );
          }
          songPlayNotifierData.getFavoritesStatus();

          playListNotifierData.getPlayList();
        },
      ),
    );
  }
}
