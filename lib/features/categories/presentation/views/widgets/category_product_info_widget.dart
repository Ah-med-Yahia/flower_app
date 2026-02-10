import 'package:flower_app/core/constants/app_text_constants.dart';
import 'package:flower_app/core/theme/app_colors.dart';
import 'package:flower_app/core/widgets/spacing.dart';
import 'package:flower_app/features/categories/domain/entities/category_products_response_entity/category_product_entity.dart';
import 'package:flutter/material.dart';

class CategoryProductInfoWidget extends StatelessWidget {
  const CategoryProductInfoWidget({super.key, required this.product});

  final CategoryProductEntity product;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final screenSize = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          product.title,
          style: textTheme.labelMedium!.copyWith(fontWeight: FontWeight.w400),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        4.verticalSpacing,
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              '${AppTextConstants.egp} ${product.priceAfterDiscount ?? product.price}',
              style: Theme.of(
                context,
              ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600),
            ),
            (screenSize.width * 0.018).horizontalSpacing,
            Visibility(
              visible: product.priceAfterDiscount != null,
              child: Text(
                '${product.price}',
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: AppColors.textSecondary,
                  decoration: TextDecoration.lineThrough,
                ),
              ),
            ),
            (screenSize.width * 0.018).horizontalSpacing,
            Visibility(
              visible: product.discountPercentage != null,
              child: Text(
                '${product.discountPercentage}',
                style: textTheme.labelLarge?.copyWith(color: AppColors.green),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
