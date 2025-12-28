import 'package:flutter/material.dart';

import '../../../../../../../core/constants/app_text_constants.dart';

class CustomElevatedButtonWidget extends StatelessWidget {
  const CustomElevatedButtonWidget({super.key, required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final myTextTheme = Theme.of(context).textTheme;
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton(
        onPressed: () => onPressed,
        child: Text(
          AppTextConstants.confirmBtn,
          style: myTextTheme.titleSmall?.copyWith(
            fontSize: 16,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
