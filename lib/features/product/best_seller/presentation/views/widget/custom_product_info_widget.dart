import 'package:flutter/material.dart';

import '../../../../../../core/constants/app_text_constants.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/widgets/spacing.dart';

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
                '${AppTextConstants.egp} ${price?.toStringAsFixed(0)}',
                style: TextTheme.of(context).titleSmall,
              ),
              4.horizontalSpacing,
              if (originalPrice != null) ...[
                4.verticalSpacing,
                Text(
                  '${AppTextConstants.egp} ${originalPrice?.toStringAsFixed(0)}',
                  style: TextTheme.of(context).bodySmall?.copyWith(
                    fontSize: 12,
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.w400,
                    decoration: TextDecoration.lineThrough,
                  ),
                ),
              ],
              4.horizontalSpacing,
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
