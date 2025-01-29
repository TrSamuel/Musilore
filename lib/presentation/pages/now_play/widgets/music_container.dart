import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:musilore/core/utils/color/colors.dart';
import 'package:musilore/core/utils/size/size.dart';
import 'package:musilore/state/notifier/song_notifier.dart';
import 'package:provider/provider.dart';

class MusicContainer extends StatelessWidget {
  final bool darkTheme;
  final Color secondaryColor;
  const MusicContainer({
    super.key,
    required this.darkTheme,
    required this.secondaryColor,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<SongNotifier>(
      builder: (context, songPLayNotiferData, _) {
        final Uint8List? image =
            songPLayNotiferData.currentPlayAudioModel!.image;
        return Container(
          width: fullsize(context: context).width * 0.8,
          height: fullsize(context: context).width * 0.8,
          decoration: BoxDecoration(
              image: image != null
                  ? DecorationImage(
                      image: MemoryImage(image), fit: BoxFit.cover)
                  : null,
              color: darkTheme ? primaryColor : primaryTextColor,
              borderRadius: BorderRadius.circular(500),
              border: Border.all(width: 0.1, color: primaryTextColor),
              boxShadow: [BoxShadow(color: secondaryColor, blurRadius: 50)]),
          child: image == null
              ? Center(
                  child: Icon(
                    color: darkTheme ? primaryTextColor : secondaryColor,
                    size: 150,
                    CupertinoIcons.music_note_2,
                  ),
                )
              : null,
        );
      },
    );
  }
}
