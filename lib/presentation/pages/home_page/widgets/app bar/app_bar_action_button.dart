import 'package:flutter/material.dart';

class AppBarActionButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback action;
  const AppBarActionButton({
    super.key,
    required this.icon,
    required this.action,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: action,
      icon: Icon(icon),
    );
  }
}