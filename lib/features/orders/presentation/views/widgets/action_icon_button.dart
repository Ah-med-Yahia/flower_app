import 'package:flower_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class ActionIconButton extends StatelessWidget {
  final IconData? icon;
  final Widget? iconWidget;
  final VoidCallback onTap;

  const ActionIconButton({
    super.key,
    this.icon,
    this.iconWidget,
    required this.onTap,
  }) : assert(icon != null || iconWidget != null);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 38,
        height: 38,
        decoration: BoxDecoration(
          color: AppColors.lightPink,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: iconWidget ?? Icon(icon, color: AppColors.primary, size: 20),
        ),
      ),
    );
  }
}
