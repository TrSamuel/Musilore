import 'package:flutter/material.dart';
import 'package:musilore/core/utils/color/colors.dart';
import 'package:musilore/core/utils/size/size.dart';
import 'package:musilore/core/utils/text/txt.dart';
import 'package:musilore/data/model/audio%20model/audio_model.dart';
import 'package:musilore/function/player_fun.dart';
import 'package:musilore/presentation/widgets/song_related/song_listtile/song_list_tile.dart';
import 'package:musilore/state/notifier/song_notifier.dart';
import 'package:musilore/state/notifier/theme_notifier.dart';
import 'package:provider/provider.dart';

class SongsPageView extends StatelessWidget {
  const SongsPageView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<SongNotifier>(
      builder: (context, songNotifierData, _) {
        if (songNotifierData.songsList.isEmpty) {
          return Center(
            child: Consumer<ThemeModel>(
              builder: (context, themeData, _) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'No songs availabe in this device',
                      style: TextStyle(
                        color: themeData.darkThemeStatus
                            ? primaryTextColor
                            : primaryColor,
                        fontFamily: 'text-font',
                        fontSize: h3Size,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        songNotifierData.getSongs(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: themeData.secondaryColor,
                        foregroundColor: primaryColor,
                        textStyle: const TextStyle(
                          fontFamily: textFontFamilyName,
                          fontSize: h3Size,
                        ),
                      ),
                      child: const Text("Sync now"),
                    )
                  ],
                );
              },
            ),
          );
        }
        final List<AudioModel> audioModelList = songNotifierData.songsList;
        PlayerFunctions.instance.audioModelList.clear();
        PlayerFunctions.instance.audioModelList.addAll(audioModelList);
        return ListView.builder(
          itemCount: audioModelList.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: SongListTile(
                icon: Icons.music_note,
                audioModelList: audioModelList,
                initialIndex: index,
              
              ),
            );
          },
        );
      },
    );
  }
}
