import 'package:flutter/material.dart';

import '../../../../../core/constants/app_text_constants.dart';

class CustomGenderSelected extends StatelessWidget {
  const CustomGenderSelected({
    super.key,
    required this.onChanged,
    required this.selectedGender,
  });

  final void Function(String?) onChanged;
  final String selectedGender;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          AppTextConstants.gender,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(width: 20),
        RadioGroup<String>(
          groupValue: selectedGender,
          onChanged: onChanged,
          child: Row(
            children: [
              Radio<String>(value: AppTextConstants.female),
              Text(
                AppTextConstants.female,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(width: 20),
              Radio<String>(value: AppTextConstants.male),
              Text(
                AppTextConstants.male,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
