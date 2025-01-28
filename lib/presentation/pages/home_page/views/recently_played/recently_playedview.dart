// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:musilore/function/player_fun.dart';
import 'package:musilore/presentation/pages/home_page/views/recently_played/widgets/error_msg_widget.dart';
import 'package:musilore/presentation/widgets/song_related/song_list_tile.dart';
import 'package:musilore/state/notifier/song_notifier.dart';
import 'package:provider/provider.dart';

class RecentlyPlayedPageView extends StatelessWidget {
  const RecentlyPlayedPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SongNotifier>(
      builder: (context, songNotifierData, _) {
        final audioModelList = songNotifierData.recentlySongs;
        if (audioModelList.isEmpty) {
          return const ErrorMessageWidget();
        }
        PlayerFunctions.instance.audioModelList.clear();
        PlayerFunctions.instance.audioModelList.addAll(audioModelList);
        return ListView.builder(
          itemCount: audioModelList.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: SongListTile(
                initialIndex: index,
                audioModelList: audioModelList,
                icon: Icons.history,
              ),
            );
          },
        );
      },
    );
  }
}
