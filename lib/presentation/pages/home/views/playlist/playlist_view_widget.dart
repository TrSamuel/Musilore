import 'package:flutter/material.dart';
import 'package:musilore/presentation/pages/home/views/playlist/widgets/create_playlist_btn.dart';
import 'package:musilore/presentation/pages/home/views/playlist/widgets/playlist_list/playlist_listview.dart';

class PlayListPageView extends StatelessWidget {
  const PlayListPageView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Stack(
      children: [
        PlaylistListView(),
        CreatePlayListButton(),
      ],
    );
  }
}
