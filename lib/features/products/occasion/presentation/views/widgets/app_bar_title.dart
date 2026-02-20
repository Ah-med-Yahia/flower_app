import 'package:flower_app/core/constants/app_text_constants.dart';
import 'package:flutter/material.dart';

class AppBarTitle extends StatelessWidget {
  const AppBarTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppTextConstants.occasion,
          style: Theme.of(
            context,
          ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 2),
        Text(
          AppTextConstants.bloomExquisiteBestSellers,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }
}
