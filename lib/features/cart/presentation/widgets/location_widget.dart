import 'package:flower_app/core/constants/app_text_constants.dart';
import 'package:flower_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class LocationWidget extends StatelessWidget {
  const LocationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;
    return Row(
      children: [
        const Icon(Icons.location_on_outlined, color: AppColors.textSecondary),
        const SizedBox(width: 8),
        Text(AppTextConstants.deliverTo, style: textStyle.bodyMedium),
        Expanded(
          child: Text(
            '2XVP+XC - Sheikh Zayed.....',
            style: textStyle.bodyMedium?.copyWith(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.bold,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const Icon(Icons.keyboard_arrow_down, color: AppColors.textSecondary),
      ],
    );
  }
}
