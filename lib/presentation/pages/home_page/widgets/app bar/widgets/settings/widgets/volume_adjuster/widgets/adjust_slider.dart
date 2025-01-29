import 'package:flutter/material.dart';
import 'package:musilore/core/utils/color/colors.dart';
import 'package:musilore/function/player_fun.dart';
import 'package:musilore/state/notifier/valuenotifiers.dart';

class VolumeAdjustSlider extends StatelessWidget {
  const VolumeAdjustSlider({
    super.key,
    required this.darkThemeStatus,
    required this.secondaryColor,
  });

  final bool darkThemeStatus;
  final Color secondaryColor;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ValueListenableBuilder(
        valueListenable: volumeNotifier,
        builder: (context, newVolume, _) => Slider(
          min: 0,
          max: 1,
          value: newVolume,
          onChanged: (newVolumeValue) async {
            await PlayerFunctions.instance.changeVolume(newVolumeValue);
          },
          thumbColor: darkThemeStatus ? secondaryColor : primaryColor,
          inactiveColor: darkThemeStatus
              ? secondaryColor.withOpacity(0.5)
              : primaryTextColor.withOpacity(0.5),
          activeColor: darkThemeStatus ? secondaryColor : primaryColor,
        ),
      ),
    );
  }
}
