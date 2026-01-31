import 'package:flutter/material.dart';

import '../../../../../core/constants/app_text_constants.dart';
import '../../../../../core/theme/app_colors.dart';

class TermsAndConditionsWidget extends StatelessWidget {
  const TermsAndConditionsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        text: AppTextConstants.creatingAccountAgreement.replaceAll(
          AppTextConstants.termsAndConditions,
          '',
        ),
        style: const TextStyle(
          fontSize: 13,
          color: AppColors.textSecondary,
          fontWeight: FontWeight.bold,
        ),
        children: [
          TextSpan(
            text: AppTextConstants.termsAndConditions,
            style: const TextStyle(
              color: AppColors.primary,
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.underline,
            ),
          ),
        ],
      ),
    );
  }
}
