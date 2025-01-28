import 'package:flutter/material.dart';
import 'package:musilore/core/utils/color/colors.dart';
import 'package:musilore/core/utils/size/size.dart';
import 'package:musilore/core/utils/text/txt.dart';
import 'package:musilore/presentation/pages/open_playlist/widgets/app_bar/appbar_open_playlistpage.dart';
import 'package:musilore/presentation/pages/open_playlist/widgets/openplaylist_list_tile.dart';
import 'package:musilore/state/notifier/play_list_notifier.dart';
import 'package:musilore/state/notifier/theme_notifier.dart';
import 'package:provider/provider.dart';

class OpenPlayListPage extends StatelessWidget {
  final String playListName;
  final bool favoritesStatus;
  final String playListId;
  const OpenPlayListPage({
    super.key,
    required this.playListName,
    required this.favoritesStatus,
    required this.playListId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbarForOpenPlayListPage(
        playListId: playListId,
        context: context,
        playlistName: playListName,
        isFavorites: favoritesStatus,
      ),
      body: Consumer2<ThemeModel, PlayListNotifier>(
        builder: (context, themeData, playListNotifierData, _) => Container(
          width: double.infinity,
          height: double.infinity,
          color: themeData.darkThemeStatus ? primaryColor : primaryTextColor,
          child: Center(
            child: Builder(
              builder: (context) {
                if (playListNotifierData
                    .currentSelectedPlayListsongs.isNotEmpty) {
                  return ListView.builder(
                    itemCount: playListNotifierData
                        .currentSelectedPlayListsongs.length,
                    itemBuilder: (context, index) => OpenPLayListListTile(
                      audioModel: playListNotifierData
                          .currentSelectedPlayListsongs[index],
                      initialndex: index,
                      favoriteStatus: favoritesStatus,
                      playListId: playListId,
                    ),
                  );
                } else {
                  return Text(
                    'No songs available in this playlist',
                    style: TextStyle(
                      color: themeData.darkThemeStatus
                          ? primaryTextColor
                          : primaryColor,
                      fontFamily: textFontFamilyName,
                      fontSize: h3Size,
                    ),
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
