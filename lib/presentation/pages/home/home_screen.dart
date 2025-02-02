import 'package:flutter/material.dart';
import 'package:musilore/core/utils/color/colors.dart';
import 'package:musilore/presentation/pages/home/views/playlist/playlist_view_widget.dart';
import 'package:musilore/presentation/pages/home/views/recently_played/recently_playedview.dart';
import 'package:musilore/presentation/pages/home/views/songs/songs_view_widget.dart';
import 'package:musilore/presentation/pages/home/widgets/app%20bar/app_bar.dart';
import 'package:musilore/presentation/pages/home/widgets/miniplayer/mini_player.dart';
import 'package:musilore/state/notifier/theme_notifier.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: appBarHome(context),
          body: Consumer<ThemeModel>(
            builder: (context, themeData, child) => Container(
              width: double.infinity,
              height: double.infinity,
              color:
                  themeData.darkThemeStatus ? primaryColor : primaryTextColor,
              child: const Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  TabBarView(
                    children: [
                      SongsPageView(),
                      RecentlyPlayedPageView(),
                      PlayListPageView(),
                    ],
                  ),
                  MiniPlayer(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
