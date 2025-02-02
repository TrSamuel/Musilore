import 'package:flutter/material.dart';
import 'package:musilore/core/utils/color/colors.dart';
import 'package:musilore/core/utils/size/size.dart';
import 'package:musilore/core/utils/text/txt.dart';
import 'package:musilore/data/model/playlist%20model/audio_play_list_model.dart';
import 'package:musilore/presentation/pages/home/views/playlist/widgets/playlist_list/widgets/more_option_btn.dart';
import 'package:musilore/state/notifier/play_list_notifier.dart';
import 'package:musilore/state/notifier/theme_notifier.dart';
import 'package:provider/provider.dart';

class PlayListViewListTile extends StatelessWidget {
  const PlayListViewListTile({
    super.key,
    required this.playList,
    required this.action,
    required this.isFavorites,
  });

  final AudioPlayListModel playList;
  final VoidCallback action;
  final bool isFavorites;

  @override
  Widget build(BuildContext context) {
    return Consumer2<ThemeModel, PlayListNotifier>(
      builder: (context, themeData, playListNotifierData, _) => Card(
        shadowColor: primaryTextColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        elevation: 5,
        color: themeData.darkThemeStatus
            ? themeData.secondaryColor
            : primaryTextColor,
        child: ListTile(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          leading: Icon(
            isFavorites ? Icons.favorite : Icons.playlist_play,
            color: primaryColor,
          ),
          title: Text(playList.playListName),
          titleTextStyle: const TextStyle(
            color: primaryColor,
            fontFamily: textFontFamilyName,
            fontSize: h3Size,
          ),
          trailing: MoreOptionPLayList(
              playListNotifierData: playListNotifierData,
              themeData: themeData,
              playList: playList,
              isFavorites: isFavorites),
          onTap: action,
        ),
      ),
    );
  }
}
