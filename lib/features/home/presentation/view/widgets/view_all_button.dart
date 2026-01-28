import 'package:flutter/material.dart';

import '../../../../../core/constants/app_text_constants.dart';
import '../../../../../core/theme/app_colors.dart';

class ViewAllButton extends StatelessWidget {
  const ViewAllButton({super.key, required this.onPressed});

  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    final bodyMedium = Theme.of(context).textTheme.bodyMedium;
    return TextButton(
      onPressed: onPressed,
      child: Text(
        AppTextConstants.viewAll,
        style: bodyMedium?.copyWith(
          color: AppColors.primary,
          decoration: TextDecoration.underline,
          decorationColor: AppColors.primary,
          decorationThickness: 2,
        ),
      ),
    );
  }
}
