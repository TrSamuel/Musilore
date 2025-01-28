import 'package:flutter/material.dart';
import 'package:musilore/core/utils/color/colors.dart';
import 'package:musilore/core/utils/size/size.dart';
import 'package:musilore/core/utils/text/txt.dart';
import 'package:musilore/data/sources/db_functions.dart';
import 'package:musilore/data/model/playlist%20model/audio_play_list_model.dart';
import 'package:musilore/presentation/pages/home_page/views/playlist/widgets/playlist_list/playlist_listview_listtile.dart';
import 'package:musilore/presentation/pages/open_playlist/open_playlist_page.dart';

import 'package:musilore/state/notifier/play_list_notifier.dart';
import 'package:musilore/state/notifier/theme_notifier.dart';
import 'package:provider/provider.dart';

class PlaylistListView extends StatelessWidget {
  const PlaylistListView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<PlayListNotifier>(
      builder: (context, playListNotifierData, _) {
        final playListList = playListNotifierData.playListList;
        if (playListList.isEmpty) {
          return Center(
            child: Consumer<ThemeModel>(
              builder: (context, darkThemeData, _) {
                return Text(
                  'No playlist',
                  style: TextStyle(
                    color: darkThemeData.darkThemeStatus
                        ? primaryTextColor
                        : primaryColor,
                    fontFamily: 'text-font',
                    fontSize: h3Size,
                  ),
                );
              },
            ),
          );
        }
        return ListView(
          children: List.generate(
            playListList.length,
            (index) {
              final AudioPlayListModel playList = playListList[index];
              bool favoritesStatus = false;
              if (sharedPreferences.getString(constFavoritesKey) ==
                  playList.playListId) {
                favoritesStatus = true;
              }
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: PlayListViewListTile(
                  playList: playList,
                  isFavorites: favoritesStatus,
                  action: () {
                    playListNotifierData.getCurrentSelectedPlayListSongs(
                      playListId: playList.playListId,
                    );
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => OpenPlayListPage(
                          playListId: playList.playListId,
                          playListName: playList.playListName,
                          favoritesStatus: favoritesStatus,
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          ),
        );
      },
    );
  }
}
