import 'package:flutter/material.dart';
import 'package:musilore/core/utils/color/colors.dart';
import 'package:musilore/core/utils/text/txt.dart';
import 'package:musilore/state/notifier/song_notifier.dart';
import 'package:provider/provider.dart';

import '../../../../../core/utils/size/size.dart';

class SongNameWIdget extends StatelessWidget {
  const SongNameWIdget({
    super.key,
    required this.darkThemeStatus,
  });

  final bool darkThemeStatus;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: SizedBox(
        width: 100,
        child: Consumer<SongNotifier>(
          builder: (context,songPLayNotifierData,_) {
            return Text(
              songPLayNotifierData.currentPlayAudioModel!.title,
              overflow: TextOverflow.fade,
              softWrap: false,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: textFontFamilyName,
                fontSize: h2Size,
                color: darkThemeStatus ? primaryTextColor : primaryColor,
                fontWeight: FontWeight.bold,
              ),
            );
          }
        ),
      ),
    );
  }
}
