import 'package:flower_app/core/shared/presentation/widgets/spacing.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/constants/app_text_constants.dart';
import '../../../../../../core/theme/app_colors.dart';

class ProductDetailsInfo extends StatelessWidget {
  final double? priceAfterDiscount;
  final double priceBeforeDiscount;
  final bool isInStock;
  final String title;
  final String? description;

  const ProductDetailsInfo({
    super.key,
    required this.priceAfterDiscount,
    required this.priceBeforeDiscount,
    required this.isInStock,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Row(
                children: [
                  Text(
                    '${AppTextConstants.egp} ${priceAfterDiscount?.floor().toString() ?? priceBeforeDiscount.floor().toString()}',
                    style: textTheme.titleLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  8.horizontalSpacing,
                  Visibility(
                    visible: priceAfterDiscount != null,
                    child: Text(
                      '${AppTextConstants.egp} ${priceBeforeDiscount.floor().toString()}',
                      style: textTheme.titleMedium!.copyWith(
                        fontWeight: FontWeight.w500,
                        color: AppColors.grey,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Row(
                children: [
                  Text(
                    AppTextConstants.status,
                    style: textTheme.titleLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    (isInStock)
                        ? AppTextConstants.inStock
                        : AppTextConstants.outOfStock,
                    style: textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: (isInStock) ? AppColors.green : AppColors.red,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            AppTextConstants.taxNote,
            style: textTheme.titleMedium!.copyWith(color: AppColors.grey),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: textTheme.titleMedium!.copyWith(
              fontSize: 19,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            AppTextConstants.description,
            style: textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 5),
          Visibility(
            visible: description != null,
            child: Text(description!, style: textTheme.titleSmall),
          ),
        ],
      ),
    );
  }
}
