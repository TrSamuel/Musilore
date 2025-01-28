import 'package:flutter/material.dart';
import 'package:musilore/core/utils/color/colors.dart';
import 'package:musilore/core/utils/size/size.dart';
import 'package:musilore/core/utils/text/txt.dart';
import 'package:musilore/function/player_fun.dart';
import 'package:musilore/state/notifier/valuenotifiers.dart';

class PlaySlider extends StatelessWidget {
  final bool darkThemeStatus;
  final Color secondaryColor;
  const PlaySlider({
    super.key,
    required this.darkThemeStatus,
    required this.secondaryColor,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Duration?>(
        valueListenable: maxDurationValue,
        builder: (context, newMaxDurationValue, _) {
         final maxDuration = newMaxDurationValue ?? Duration.zero;
          return ValueListenableBuilder<Duration?>(
              valueListenable: playSliderDurationValue,
              builder: (context, newPlaySliderDurationValue, _) {
                 final currentDuration = newPlaySliderDurationValue ?? Duration.zero;
                return Column(
                  children: [
                    Slider(
                      min: 0,
                      max:  maxDuration.inSeconds.toDouble(),
                      value: currentDuration>maxDuration?Duration.zero.inSeconds.toDouble(): currentDuration.inSeconds.toDouble(),
                      thumbColor:
                          darkThemeStatus ? secondaryColor : primaryColor,
                      activeColor:
                          darkThemeStatus ? secondaryColor : primaryColor,
                      inactiveColor: darkThemeStatus
                          ? secondaryColor
                          : primaryColor.withOpacity(0.5),
                      onChanged: (value) {
                        final newPosition = Duration(seconds: value.toInt());
                        onSliderChanged(newPosition);
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            _formatDuration(currentDuration),
                            style: sliderTimeLabelStyle(),
                          ),
                          Text(
                            _formatDuration(maxDuration),
                            style: sliderTimeLabelStyle(),
                          )
                        ],
                      ),
                    )
                  ],
                );
              });
        });
  }

  TextStyle sliderTimeLabelStyle() {
    return TextStyle(
      color: darkThemeStatus ? primaryTextColor : primaryColor,
      fontFamily: textFontFamilyName,
      fontSize: h3Size,
    );
  }

  String _formatDuration(Duration? duration) {
    if (duration == null) return "0:00";
    final minutes = duration.inMinutes.toString().padLeft(2, '0');
    final seconds = (duration.inSeconds % 60).toString().padLeft(2, '0');
    return "$minutes:$seconds";
  }

  void onSliderChanged(Duration newPosition) {
  WidgetsBinding.instance.addPostFrameCallback((_) {
    playSliderDurationValue.value = newPosition;
    PlayerFunctions.instance.seekSong(newPosition);
  });
}
}
