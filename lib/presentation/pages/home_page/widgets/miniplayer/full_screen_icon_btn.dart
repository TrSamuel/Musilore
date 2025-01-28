import 'package:flutter/material.dart';
import 'package:musilore/core/utils/color/colors.dart';
import 'package:musilore/presentation/pages/now_play/play_screen.dart';

class FullScreenIconButton extends StatelessWidget {
  const FullScreenIconButton({
    super.key,
    required this.darkThemeStatus,
  });

  final bool darkThemeStatus;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      child: IconButton(
        color:
            darkThemeStatus ? primaryTextColor : primaryColor.withOpacity(0.7),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const PlaySongPage(),
            ),
          );
        },
        icon: const Icon(Icons.fullscreen),
      ),
    );
  }
}
