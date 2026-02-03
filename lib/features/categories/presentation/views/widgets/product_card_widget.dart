import 'package:cached_network_image/cached_network_image.dart';
import 'package:flower_app/core/constants/app_text_constants.dart';
import 'package:flower_app/core/theme/app_colors.dart';
import 'package:flower_app/core/widgets/spacing.dart';
import 'package:flower_app/features/categories/domain/entities/category_products_response_entity/product_entity.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ProductCardWidget extends StatelessWidget {
  final ProductEntity product;

  const ProductCardWidget({required this.product, super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final textTheme = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: () {},
      child: Container(
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.only(top: 6, left: 6, right: 6, bottom: 8),
        decoration: BoxDecoration(
          color: AppColors.grey.withAlpha(30),
          borderRadius: BorderRadius.circular(screenWidth * 0.03),
          border: Border.all(color: AppColors.grey, width: 0.5),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 1.2,
              child: CachedNetworkImage(
                imageUrl: product.imageCover ?? '',
                fit: BoxFit.cover,
                placeholder: (_, _) => Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    width: double.infinity,
                    height: 200.0,
                    color: Colors.white,
                  ),
                ),
                errorWidget: (_, _, _) => Center(
                  child: Icon(
                    Icons.image_not_supported,
                    size: screenWidth * 0.14,
                    color: AppColors.lightGrey,
                  ),
                ),
              ),
            ),
            8.verticalSpacing,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.title,
                    style: textTheme.labelMedium!.copyWith(
                      fontWeight: FontWeight.w400,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  4.verticalSpacing,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        '${AppTextConstants.egp} ${product.priceAfterDiscount ?? product.price}',
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      (screenWidth * 0.018).horizontalSpacing,
                      Visibility(
                        visible: product.priceAfterDiscount != null,
                        child: Text(
                          '${product.price}',
                          style: Theme.of(context).textTheme.labelLarge
                              ?.copyWith(
                                color: AppColors.textSecondary,
                                decoration: TextDecoration.lineThrough,
                              ),
                        ),
                      ),
                      (screenWidth * 0.018).horizontalSpacing,
                      Visibility(
                        visible: product.discountPercentage != null,
                        child: Text(
                          '${product.discountPercentage}',
                          style: textTheme.labelLarge?.copyWith(
                            color: AppColors.green,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              width: double.infinity,
              height: screenHeight * 0.04,
              child: ElevatedButton.icon(
                onPressed: () {},
                icon: Icon(
                  Icons.shopping_cart_outlined,
                  size: screenWidth * 0.055,
                ),
                label: Text(
                  AppTextConstants.addToCart,
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppColors.background,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
