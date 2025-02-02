import 'package:flutter/material.dart';
import 'package:musilore/presentation/pages/home/widgets/app%20bar/widgets/settings/widgets/volume_adjuster/widgets/adjust_slider.dart';
import 'package:musilore/presentation/pages/home/widgets/app%20bar/widgets/settings/widgets/volume_adjuster/widgets/label_volume_adjuster.dart';

class VolumeAdjuster extends StatelessWidget {
  const VolumeAdjuster({
    super.key,
    required this.darkThemeStatus,
    required this.secondaryColor,
  });

  final bool darkThemeStatus;
  final Color secondaryColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const LabelVolumeAdjuster(),
          VolumeAdjustSlider(darkThemeStatus: darkThemeStatus, secondaryColor: secondaryColor)
        ],
      ),
    );
  }
}

