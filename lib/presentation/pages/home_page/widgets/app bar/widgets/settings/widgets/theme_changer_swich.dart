import 'package:flutter/material.dart';
import 'package:musilore/core/utils/color/colors.dart';
import 'package:musilore/state/notifier/theme_notifier.dart';
import 'package:provider/provider.dart';

class ThemeChangerSwitch extends StatelessWidget {
  const ThemeChangerSwitch({
    super.key,
    required this.darkThemeStatus,
    required this.secondaryColor,
  });

  final bool darkThemeStatus;
  final Color secondaryColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Dark theme'),
        Consumer<ThemeModel>(
          builder: (context, themeData, _) => Switch(
            trackColor: MaterialStatePropertyAll(
              darkThemeStatus
                  ? secondaryColor.withOpacity(0.5)
                  : primaryTextColor.withOpacity(0.5),
            ),
            thumbColor: darkThemeStatus
                ? MaterialStatePropertyAll(secondaryColor)
                : const MaterialStatePropertyAll(primaryColor),
            value: darkThemeStatus,
            onChanged: (_) {
              themeData.changeTheme();
              Navigator.pop(context);
            },
          ),
        )
      ],
    );
  }
}