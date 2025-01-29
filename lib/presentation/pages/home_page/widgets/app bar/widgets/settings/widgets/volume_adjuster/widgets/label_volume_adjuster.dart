import 'package:flutter/material.dart';
import 'package:musilore/core/utils/size/size.dart';
import 'package:musilore/core/utils/text/txt.dart';

class LabelVolumeAdjuster extends StatelessWidget {
  const LabelVolumeAdjuster({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Text(
      "Volume",
      textAlign: TextAlign.center,
      style: TextStyle(
        fontFamily: textFontFamilyName,
        fontSize: h3Size,
      ),
    );
  }
}
