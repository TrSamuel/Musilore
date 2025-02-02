import 'package:flutter/material.dart';
import 'package:musilore/core/utils/color/colors.dart';
import 'package:musilore/presentation/pages/create_update_playlist/create_or_update_playlist_page.dart';
import 'package:musilore/state/notifier/play_list_notifier.dart';
import 'package:musilore/state/notifier/theme_notifier.dart';
import 'package:provider/provider.dart';

class CreatePlayListButton extends StatelessWidget {
  const CreatePlayListButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 120),
        child: Consumer2<ThemeModel, PlayListNotifier>(
          builder: (context, themeData, playListNotifierData, _) =>
              CircleAvatar(
            backgroundColor: themeData.darkThemeStatus
                ? primaryTextColor
                : themeData.secondaryColor,
            foregroundColor: primaryColor,
            radius: 25,
            child: IconButton(
              iconSize: 30,
              onPressed: () {
                playListNotifierData.selectedSongsList.clear();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CreateOrUpdatePLayListScreen(),
                  ),
                );
              },
              icon: const Icon(Icons.add),
            ),
          ),
        ),
      ),
    );
  }
}
