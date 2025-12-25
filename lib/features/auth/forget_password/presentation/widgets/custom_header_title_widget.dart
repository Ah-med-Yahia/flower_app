import 'package:flutter/material.dart';
import 'package:online_exam_app/core/theme/app_colors.dart';

class CustomHeaderTitleWidget extends StatelessWidget {
  final String title;
  final String? subtitle;
  final TextAlign? titleAlign;
  final TextAlign? subtitleAlign;

  const CustomHeaderTitleWidget({
    super.key,
    required this.title,
    this.subtitle,
    this.titleAlign = TextAlign.center,
    this.subtitleAlign = TextAlign.center,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          textAlign: titleAlign,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        if (subtitle != null) ...[
          const SizedBox(height: 8),
          Text(
            subtitle!,
            textAlign: subtitleAlign,
            style: const TextStyle(
              fontSize: 16,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ],
    );
  }
}
