import 'package:flutter/material.dart';
import 'package:flower_app/core/constants/app_text_constants.dart';

class AppBarTitle extends StatelessWidget {
  const AppBarTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppTextConstants.occasion,
          style: Theme.of(context).textTheme.titleLarge,
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
