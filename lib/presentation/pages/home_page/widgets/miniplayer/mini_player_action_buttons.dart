import 'package:flutter/material.dart';
import 'package:musilore/core/utils/color/colors.dart';
import 'package:musilore/state/notifier/theme_notifier.dart';
import 'package:provider/provider.dart';

class MiniPLayerActionButtons extends StatelessWidget {
  final VoidCallback action;
  final IconData icon;
  const MiniPLayerActionButtons({
    super.key,
    required this.action,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: IconButton(
        onPressed: action,
        icon: Consumer<ThemeModel>(builder: (context, themeData, _) {
          return Icon(
            size: 30,
            icon,
            color: themeData.darkThemeStatus
                ? themeData.secondaryColor
                : primaryColor,
          );
        }),
      ),
    );
  }
}
