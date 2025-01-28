import 'package:flutter/material.dart';
import 'package:musilore/core/utils/color/colors.dart';
import 'package:musilore/core/utils/size/size.dart';
import 'package:musilore/core/utils/text/txt.dart';
import 'package:musilore/data/model/audio%20model/audio_model.dart';
import 'package:musilore/data/model/playlist%20model/audio_play_list_model.dart';
import 'package:musilore/data/sources/db_functions.dart';
import 'package:musilore/presentation/widgets/snack_bar.dart';
import 'package:musilore/state/notifier/play_list_notifier.dart';
import 'package:provider/provider.dart';

class SelectPlayListWidget extends StatelessWidget {
  final bool darkThemeStatus;
  final AudioModel audioModel;
  const SelectPlayListWidget({
    super.key,
    required this.playLists,
    required this.secondaryColor,
    required this.darkThemeStatus,
    required this.audioModel,
  });

  final List<AudioPlayListModel> playLists;
  final Color secondaryColor;

  @override
  Widget build(BuildContext context) {
    return Consumer<PlayListNotifier>(
      builder: (context, playListNotifier, _) => Column(
        children: [
          const SizedBox(
            height: 36,
          ),
          DropdownButton(
            value: playListNotifier.selectedPlayListId,
            items: [
              const DropdownMenuItem(
                value: '',
                child: Text("Select"),
              ),
              ...List.generate(
                playLists.length,
                (index) {
                  return DropdownMenuItem(
                    value: playLists[index].playListId,
                    child: Text(playLists[index].playListName),
                  );
                },
              )
            ],
            onChanged: (String? playListId) {
              playListNotifier.selectPlayList(
                id: playListId!,
              );
            },
          ),
          if (playListNotifier.errorTextDropDown)
            Text(
              'Select playlist',
              style: TextStyle(
                fontSize: h3Size,
                fontFamily: textFontFamilyName,
                color: darkThemeStatus
                    ? primaryColor.withOpacity(0.5)
                    : primaryColor.withOpacity(0.75),
              ),
            ),
          Padding(
            padding: const EdgeInsets.only(top: 18),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                fixedSize: Size.fromWidth(
                  MediaQuery.sizeOf(context).width * 0.6,
                ),
                backgroundColor: darkThemeStatus
                    ? secondaryColor
                    : primaryTextColor.withOpacity(0.7),
                foregroundColor: primaryColor,
                textStyle: const TextStyle(
                  fontFamily: textFontFamilyName,
                  fontSize: h3Size,
                ),
              ),
              onPressed: () async {
                if (playListNotifier.selectedPlayListId.trim().isNotEmpty) {
                  await DbFunctions.instance
                      .addToPlayListBox(
                    audiomodelInstance: audioModel,
                    playListId: playListNotifier.selectedPlayListId,
                  )
                      .then(
                    (_) {
                      playListNotifier.getPlayList();
                      Navigator.pop(context);
                      snackbarWidget(
                        text: 'Added to playlist',
                        context: context,
                        secondaryColor: secondaryColor,
                      );
                      playListNotifier.falseErrorTextDropDown();
                    },
                  );
                } else {
                  playListNotifier.trueErrorTextDropDown();
                }
              },
              child: const Text("Submit"),
            ),
          ),
        ],
      ),
    );
  }
}
