import 'package:flutter/material.dart';
import 'package:musilore/core/utils/color/colors.dart';
import 'package:musilore/core/utils/size/size.dart';
import 'package:musilore/core/utils/text/txt.dart';
import 'package:musilore/presentation/pages/add_songs_playlist/add_songs_playlist.dart';
import 'package:musilore/state/notifier/play_list_notifier.dart';
import 'package:musilore/state/notifier/song_notifier.dart';
import 'package:musilore/state/notifier/theme_notifier.dart';
import 'package:provider/provider.dart';

class AddSongsBtn extends StatelessWidget {
  final ThemeModel themeData;
  final PlayListNotifier playListNotifierData;
  const AddSongsBtn({
    super.key,
    required this.themeData, required this.playListNotifierData,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: themeData.secondaryColor,
            foregroundColor: primaryColor,
            fixedSize: Size.fromWidth(MediaQuery.sizeOf(context).width * 0.8)),
        onPressed: () {
          final songsList =
              Provider.of<SongNotifier>(context, listen: false).songsList;
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddSongsToPLayList(
                themeData: themeData,
                audioModelList: songsList,
                playListNotifierData: playListNotifierData,
              ),
            ),
          );
        },
        child: const Text(
          "Add songs",
          textAlign: TextAlign.center,
          style: TextStyle(
              color: primaryColor,
              fontFamily: textFontFamilyName,
              fontSize: h3Size,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
