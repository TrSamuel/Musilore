import 'package:flutter/material.dart';
import 'package:musilore/core/utils/color/colors.dart';
import 'package:musilore/state/notifier/song_notifier.dart';
import 'package:musilore/state/notifier/theme_notifier.dart';
import 'package:provider/provider.dart';
import 'package:musilore/function/player_fun.dart';

class CloseMiniPLayerIconButton extends StatelessWidget {
  const CloseMiniPLayerIconButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 50,
      child: Consumer<ThemeModel>(builder: (context, darkThemeData, _) {
        return IconButton(
            color: darkThemeData.darkThemeStatus
                ? primaryTextColor
                : primaryColor.withOpacity(0.7),
            onPressed: () async {
              Provider.of<SongNotifier>(context, listen: false)
                  .closeMiniPlayer();
              PlayerFunctions.instance.stopSong();
            },
            icon: const Icon(Icons.close));
      }),
    );
  }
}
