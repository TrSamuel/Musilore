import 'package:flutter/material.dart';
import 'package:musilore/core/utils/color/colors.dart';

class SongPlayActionButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback action;
  final Color? color;
  final bool darkThemeStatus;
  final Color secondaryColor;
  const SongPlayActionButton({
    super.key,
    required this.icon,
    required this.action,
    this.color,
    required this.darkThemeStatus, required this.secondaryColor,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      color: color ?? (darkThemeStatus ? secondaryColor : primaryColor),
      iconSize: 45,
      onPressed: action,
      icon: Icon(
        icon,
      ),
    );
  }
}
