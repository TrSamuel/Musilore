import 'package:flutter/material.dart';
import 'package:musilore/core/utils/color/colors.dart';
import 'package:musilore/data/sources/db_functions.dart';
import 'package:musilore/presentation/widgets/snack_bar.dart';
import 'package:musilore/state/notifier/play_list_notifier.dart';
import 'package:musilore/state/notifier/theme_notifier.dart';
import 'package:provider/provider.dart';

class SubmitButton extends StatelessWidget {
  const SubmitButton({
    super.key,
    required this.formKey,
    required this.playListId,
    required this.playlistNameController,
    required this.playListName,
    required this.themeData, required this.playListNotifierData,
  });

  final GlobalKey<FormState> formKey;
  final String? playListId;
  final TextEditingController playlistNameController;
  final String? playListName;
  final ThemeModel themeData;
  final PlayListNotifier playListNotifierData;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            foregroundColor: primaryColor,
            backgroundColor: themeData.secondaryColor),
        onPressed: () async {
          if (formKey.currentState!.validate()) {
            await DbFunctions.instance
                .createOrUpdatejPlayList(
                  playListId: playListId,
                  playListName: playlistNameController.text,
                  listAudioModel: playListNotifierData.selectedSongsList,
                )
                .then(
                  (_) => {
                    if (playListId != null)
                      {
                        playListNotifierData.getCurrentSelectedPlayListSongs(
                          playListId: playListId!,
                        ),
                      },
                    snackbarWidget(
                      text: playListId == null
                          ? 'Playlist created'
                          : 'Playlist updated',
                      context: context,
                      secondaryColor: themeData.secondaryColor,
                    ),
                    Provider.of<PlayListNotifier>(context, listen: false)
                        .getPlayList(),
                    Navigator.pop(context),
                  },
                );
          }
        },
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 105),
            child: Text(playListName != null ? 'Save changes' : 'Submit')),
      ),
    );
  }
}
