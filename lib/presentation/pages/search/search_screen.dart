import 'package:flutter/material.dart';
import 'package:musilore/core/utils/color/colors.dart';
import 'package:musilore/data/model/audio%20model/audio_model.dart';
import 'package:musilore/function/player_fun.dart';
import 'package:musilore/presentation/pages/search/widgets/app_bar.dart';
import 'package:musilore/presentation/widgets/song_related/song_listtile/song_list_tile.dart';
import 'package:musilore/state/notifier/search_notifier.dart';
import 'package:musilore/state/notifier/theme_notifier.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeModel>(
      builder: (context, newDarkThemeData, _) {
        return SafeArea(
          child: Scaffold(
            backgroundColor: newDarkThemeData.darkThemeStatus
                ? primaryColor
                : primaryTextColor,
            appBar: appBar(newDarkThemeData, context),
            body: Consumer<SearchNotifer>(
              builder: (context, searchNotifierData, _) {
                final List<AudioModel> songsList =
                    searchNotifierData.searchedSongsList;

                PlayerFunctions.instance.audioModelList.clear();
                PlayerFunctions.instance.audioModelList.addAll(songsList);
                return ListView.builder(
                  itemCount: songsList.length,
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SongListTile(
                      audioModelList: songsList,
                      initialIndex: index,
                      icon: Icons.music_note,
                      searchKeyboardShowStatus: true,
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
