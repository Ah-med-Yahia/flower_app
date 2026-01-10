import 'package:flutter/material.dart';
import 'package:online_exam_app/core/constants/app_text_constants.dart';
import 'package:online_exam_app/core/theme/app_colors.dart';

class ProductDetailsInfo extends StatelessWidget {
  final double priceAfterDiscount;
  final double priceBeforeDiscount;
  final int quantity;
  final String title;
  final String description;

  const ProductDetailsInfo({
    super.key,
    required this.priceAfterDiscount,
    required this.priceBeforeDiscount,
    required this.quantity,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    '${AppTextConstants.egp} ${priceAfterDiscount.floor().toString()}',
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 20),
                  Text(
                    '${AppTextConstants.egp} ${priceBeforeDiscount.floor().toString()}',
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: AppColors.grey,
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    AppTextConstants.status,
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    (quantity > 0)
                        ? AppTextConstants.inStock
                        : AppTextConstants.outOfStock,
                    style: Theme.of(context).textTheme.titleLarge!,
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            AppTextConstants.taxNote,
            style: Theme.of(
              context,
            ).textTheme.titleMedium!.copyWith(color: AppColors.grey),
          ),
          const SizedBox(height: 5),
          Text(
            title,
            style: Theme.of(
              context,
            ).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          Text(
            AppTextConstants.description,
            style: Theme.of(
              context,
            ).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 5),
          Text(
            description,
            style: Theme.of(
              context,
            ).textTheme.titleLarge!.copyWith(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
