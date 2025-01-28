import 'package:flutter/material.dart';
import 'package:musilore/core/utils/color/colors.dart';
import 'package:musilore/presentation/widgets/app_name_logo/app_name_text_widget.dart';

class AppLogo extends StatelessWidget {
  final double width;
  final bool darkThemeStatus;
  final Color secondaryColor;
  const AppLogo({
    super.key,
    required this.width,
    required this.darkThemeStatus, required this.secondaryColor,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Container(
      width: size.width * width,
      height: size.width * width,
      decoration: BoxDecoration(
        color: darkThemeStatus ? primaryColor : primaryTextColor,
        borderRadius: const BorderRadius.all(
          Radius.circular(
            500,
          ),
        ),
        boxShadow: [
          BoxShadow(
              blurRadius: 10,
              color: darkThemeStatus ? primaryColor : secondaryColor),
          BoxShadow(
              blurRadius: 200,
              color: darkThemeStatus ? secondaryColor : primaryTextColor),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/logo/${darkThemeStatus ? 'music' : 'music-2'}.png',
            width: size.width * width * 0.5,
          ),
          AppNameTextWidget(
            fontSize: 44,
            newDarkThemeStatus: darkThemeStatus,
            secondaryColor: secondaryColor,
          ),
        ],
      ),
    );
  }
}
