import 'package:flutter/material.dart';
import 'package:musilore/core/utils/color/colors.dart';
import 'package:musilore/core/utils/size/size.dart';
import 'package:musilore/core/utils/text/txt.dart';

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
          const Text(
            "Volume",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: textFontFamilyName,
              fontSize: h3Size,
            ),
          ),
          Expanded(
            child: Slider(
              min: 0,
              max: 100,
              value: 50,
              onChanged: (value) {},
              thumbColor:
                  darkThemeStatus ? secondaryColor : primaryColor,
              inactiveColor: darkThemeStatus
                  ? secondaryColor.withOpacity(0.5)
                  : primaryTextColor.withOpacity(0.5),
              activeColor:
                  darkThemeStatus ? secondaryColor : primaryColor,
            ),
          )
        ],
      ),
    );
  }
}
