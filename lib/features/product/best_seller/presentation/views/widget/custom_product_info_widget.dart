import 'package:flower_app/core/widgets/spacing.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/theme/app_colors.dart';

class CustomProductInfoWidget extends StatelessWidget {
  final String? productName;
  final double? price;
  final double? originalPrice;
  final double? discountPercentage;

  const CustomProductInfoWidget({
    super.key,
    this.productName,
    this.price,
    this.originalPrice,
    this.discountPercentage,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product Name
          Text(
            productName ?? '',
            style: TextTheme.of(context).bodySmall?.copyWith(
              fontSize: 12,
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w400,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          4.verticalSpacing,
          // Price Section
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'EGP ${price?.toStringAsFixed(0)}',
                style: TextTheme.of(context).titleSmall,
              ),
              if (originalPrice != null) ...[
                4.verticalSpacing,
                Text(
                  '${originalPrice?.toStringAsFixed(0)}',
                  style: TextTheme.of(context).bodySmall?.copyWith(
                    fontSize: 12,
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.w400,
                    decoration: TextDecoration.lineThrough,
                  ),
                ),
              ],
              if (discountPercentage != null) ...[
                4.verticalSpacing,
                Text(
                  '${discountPercentage?.toInt()}%',
                  style: TextTheme.of(context).bodySmall?.copyWith(
                    fontSize: 12,
                    color: AppColors.green,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}
