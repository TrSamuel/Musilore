// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:musilore/core/utils/color/colors.dart';
import 'package:musilore/core/utils/enum/song_play_enum.dart';
import 'package:musilore/data/sources/db_functions.dart';
import 'package:musilore/function/player_fun.dart';
import 'package:musilore/presentation/pages/home_page/widgets/miniplayer/close_mini_player_button.dart';
import 'package:musilore/presentation/pages/home_page/widgets/miniplayer/full_screen_icon_btn.dart';
import 'package:musilore/presentation/pages/home_page/widgets/miniplayer/mini_player_action_buttons.dart';
import 'package:musilore/presentation/widgets/song_related/muisc_name_moving_widget.dart';
import 'package:musilore/state/notifier/song_notifier.dart';
import 'package:musilore/state/notifier/theme_notifier.dart';
import 'package:musilore/state/notifier/valuenotifiers.dart';
import 'package:provider/provider.dart';

class MiniPlayer extends StatelessWidget {
  const MiniPlayer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer2<ThemeModel, SongNotifier>(
      builder: (context, themeData, songPLayNotifierData, _) => Visibility(
        visible: songPLayNotifierData.miniPlayerViewStatus,
        child: Container(
          width: double.infinity,
          height: 100,
          decoration: BoxDecoration(
            color: themeData.darkThemeStatus
                ? primaryColor.withOpacity(0.9)
                : themeData.secondaryColor.withOpacity(0.8),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FullScreenIconButton(
                      darkThemeStatus: themeData.darkThemeStatus),
                  const MusicNameMovingTextWidget(),
                  const CloseMiniPLayerIconButton(),
                ],
              ),
              ValueListenableBuilder(
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
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MiniPLayerActionButtons(
                          action: () async {
                            if (PlayerFunctions.instance.currentIndex > 0) {
                              PlayerFunctions.instance.currentIndex =
                                  PlayerFunctions
                                          .instance.player.previousIndex ??
                                      PlayerFunctions.instance.currentIndex;

                              PlayerFunctions.instance.playPrevSong();
                              final songNotifierData =
                                  Provider.of<SongNotifier>(context,
                                      listen: false);

                              songNotifierData.getCurrentSong(
                                audioModel:
                                    PlayerFunctions.instance.audioModelList[
                                        PlayerFunctions.instance.currentIndex],
                              );
                              Provider.of<ThemeModel>(context, listen: false)
                                  .changeSecondaryColor(
                                imageData: PlayerFunctions
                                    .instance
                                    .audioModelList[
                                        PlayerFunctions.instance.currentIndex]
                                    .image,
                              );
                              await DbFunctions.instance.addToPlayListBox(
                                audiomodelInstance:
                                    PlayerFunctions.instance.audioModelList[
                                        PlayerFunctions.instance.currentIndex],
                                playListName: 'Recently played',
                                playListKey: 'recently-played-key',
                              );

                              songNotifierData.getRecentlySongs();
                            }
                          },
                          icon: Icons.skip_previous),
                      MiniPLayerActionButtons(
                        action: () {
                          if (songPLayNotifierData.songplayStatus ==
                              SongplayStatus.restart) {
                            songPLayNotifierData.resumeSong();
                            PlayerFunctions.instance.restartSong();
                          } else if (songPLayNotifierData.songplayStatus ==
                              SongplayStatus.play) {
                            songPLayNotifierData.pauseSong();
                            PlayerFunctions.instance.pauseSong();
                          } else {
                            songPLayNotifierData.resumeSong();
                            PlayerFunctions.instance.resumeSong();
                          }
                        },
                        icon: songPLayNotifierData.songplayStatus ==
                                    SongplayStatus.pause ||
                                songPLayNotifierData.songplayStatus ==
                                    SongplayStatus.restart
                            ? Icons.play_arrow
                            : Icons.pause,
                      ),
                      MiniPLayerActionButtons(
                          action: () async {
                            final instance = PlayerFunctions.instance;
                            final songNotifierData = Provider.of<SongNotifier>(
                                context,
                                listen: false);
                            final themeData =
                                Provider.of<ThemeModel>(context, listen: false);
                            if (instance.currentIndex <
                                instance.audioModelList.length - 1) {
                              instance.currentIndex =
                                  instance.player.nextIndex ??
                                      instance.currentIndex;
                              instance.playNextSong();

                              songNotifierData.getCurrentSong(
                                audioModel: PlayerFunctions.instance
                                    .audioModelList[instance.currentIndex],
                              );

                              themeData.changeSecondaryColor(
                                imageData: PlayerFunctions
                                    .instance
                                    .audioModelList[instance.currentIndex]
                                    .image,
                              );
                              await DbFunctions.instance.addToPlayListBox(
                                audiomodelInstance: PlayerFunctions.instance
                                    .audioModelList[instance.currentIndex],
                                playListName: 'Recently played',
                                playListKey: 'recently-played-key',
                              );

                              songNotifierData.getRecentlySongs();
                            } else if (instance.currentIndex ==
                                instance.audioModelList.length - 1) {
                              songNotifierData.getCurrentSong(
                                audioModel: instance.audioModelList[0],
                              );
                              instance.currentIndex = 0;
                              instance.playSong();

                              songNotifierData.resumeSong();
                              DbFunctions.instance
                                  .addToPlayListBox(
                                    audiomodelInstance:
                                        instance.audioModelList[0],
                                    playListName: 'Recently played',
                                    playListKey: 'recently-played-key',
                                  )
                                  .then((_) =>
                                      {songNotifierData.getRecentlySongs()});

                              themeData.changeSecondaryColor(
                                  imageData: instance.audioModelList[0].image);
                            }
                          },
                          icon: Icons.skip_next),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
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
}
