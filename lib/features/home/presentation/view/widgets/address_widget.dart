import 'package:flower_app/core/constants/app_text_constants.dart';
import 'package:flower_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class AddressWidget extends StatelessWidget {
  const AddressWidget({super.key, required this.address});

  final String address;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      children: [
        Icon(
          Icons.location_on_outlined,
          size: 25,
          color: AppColors.textPrimary,
        ),
        const SizedBox(width: 4),
        Text(
          '${AppTextConstants.deliverTo} $address ',
          style: theme.textTheme.titleMedium,
        ),
        Icon(Icons.keyboard_arrow_down, size: 30, color: AppColors.primary),
      ],
    );
  }
}
