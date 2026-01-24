import 'package:flower_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class CustomElevatedButtonWidget extends StatelessWidget {
  const CustomElevatedButtonWidget({
    super.key,
    required this.onPressed,
    this.text,
    this.backgroundColor,
    this.textColor,
  });

  final VoidCallback onPressed;
  final String? text;
  final Color? backgroundColor;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    final myTextTheme = Theme.of(context).textTheme;
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          side: backgroundColor != null
              ? BorderSide(width: 1.5, color: AppColors.textSecondary)
              : null,
        ),
        child: Text(
          text ?? '',
          style: myTextTheme.titleSmall?.copyWith(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: textColor ?? AppColors.background,
          ),
        ),
      ),
    );
  }
}
