  // ignore_for_file: use_build_context_synchronously

  import 'package:flutter/material.dart';
import 'package:musilore/data/sources/db_functions.dart';
import 'package:musilore/function/player_fun.dart';
import 'package:musilore/presentation/pages/home_page/widgets/miniplayer/play_actions/widgets/next_btn.dart';
import 'package:musilore/presentation/pages/home_page/widgets/miniplayer/play_actions/widgets/play_pause_btn.dart';
import 'package:musilore/presentation/pages/home_page/widgets/miniplayer/play_actions/widgets/prev_btn.dart';
import 'package:musilore/state/notifier/song_notifier.dart';
import 'package:musilore/state/notifier/theme_notifier.dart';
import 'package:musilore/state/notifier/valuenotifiers.dart';
import 'package:provider/provider.dart';

ValueListenableBuilder<Duration?> miniPlayerActions(SongNotifier songPLayNotifierData, ThemeModel themeData) {
    return ValueListenableBuilder(
              valueListenable: playSliderDurationValue,
              builder: (context, newPlaySliderDurationValue, _) {
                if (newPlaySliderDurationValue ==
                        PlayerFunctions.instance.player.duration &&
                    newPlaySliderDurationValue != Duration.zero) {
                  final PlayerFunctions instance = PlayerFunctions.instance;
                  if (instance.currentIndex <
                      instance.audioModelList.length - 1) {
                    instance.currentIndex =
                        PlayerFunctions.instance.player.nextIndex ??
                            instance.currentIndex;
                    instance.playNextSong();
                    playSliderDurationValue.value = Duration.zero;
                    maxDurationValue.value = instance.player.duration;

                    songPLayNotifierData.getCurrentSong(
                        audioModel:
                            instance.audioModelList[instance.currentIndex]);

                    themeData.changeSecondaryColor(
                      imageData: PlayerFunctions
                          .instance
                          .audioModelList[
                              PlayerFunctions.instance.currentIndex]
                          .image,
                    );

                    getRecentlyPlayed(
                      instance.currentIndex,
                      context,
                    );
                  } else if (instance.currentIndex ==
                      instance.audioModelList.length - 1) {
                    songPLayNotifierData.getCurrentSong(
                      audioModel: PlayerFunctions.instance.audioModelList[0],
                    );
                    PlayerFunctions.instance.currentIndex = 0;
                    PlayerFunctions.instance.playSong();

                    songPLayNotifierData.resumeSong();
                    DbFunctions.instance
                        .addToPlayListBox(
                          audiomodelInstance:
                              PlayerFunctions.instance.audioModelList[0],
                          playListName: 'Recently played',
                          playListKey: 'recently-played-key',
                        )
                        .then(
                            (_) => {songPLayNotifierData.getRecentlySongs()});

                    themeData.changeSecondaryColor(
                        imageData:
                            PlayerFunctions.instance.audioModelList[0].image);
                  }
                }
                return  Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const PrevButton(),
                    PlayPauseBtn(songPLayNotifierData: songPLayNotifierData),
                    const NextBtn(),
                  ],
                );
              },
            );
  }




  void getRecentlyPlayed(int index, BuildContext context) async {
    await DbFunctions.instance.addToPlayListBox(
      audiomodelInstance: PlayerFunctions.instance.audioModelList[index],
      playListName: 'Recently played',
      playListKey: 'recently-played-key',
    );

    Provider.of<SongNotifier>(context, listen: false).getRecentlySongs();
  }