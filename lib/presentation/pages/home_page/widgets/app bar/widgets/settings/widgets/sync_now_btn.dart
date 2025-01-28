import 'package:flutter/material.dart';
import 'package:musilore/core/utils/color/colors.dart';
import 'package:musilore/core/utils/size/size.dart';
import 'package:musilore/core/utils/text/txt.dart';
import 'package:musilore/state/notifier/song_notifier.dart';
import 'package:provider/provider.dart';

class SyncMusic extends StatelessWidget {
  const SyncMusic({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        TextButton(
          style: TextButton.styleFrom(
            foregroundColor: primaryColor,
            textStyle: const TextStyle(
              color: primaryColor,
              fontFamily: textFontFamilyName,
              fontSize: h3Size,
            ),
          ),
          onPressed: () {
            Provider.of<SongNotifier>(context, listen: false).getSongs(context);
          },
          child: const Text("Sync musics"),
        ),
      ],
    );
  }
}
