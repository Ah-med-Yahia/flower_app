import 'package:cached_network_image/cached_network_image.dart';
import 'package:flower_app/core/constants/app_text_constants.dart';
import 'package:flower_app/core/theme/app_colors.dart';
import 'package:flower_app/core/shared/presentation/widgets/loading_indicator_widget.dart';
import 'package:flower_app/features/products/occasion/domain/entities/occasion_product_entity.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final OccasionProductEntity _occasionProductEntity;

  const ProductCard(this._occasionProductEntity, {super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final fontSize = screenWidth * 0.035;

    return GestureDetector(
      onTap: () {},
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.grey.withAlpha(30),
          borderRadius: BorderRadius.circular(screenWidth * 0.03),
          border: Border.all(color: AppColors.grey, width: 0.5),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(screenWidth * 0.03),

              child: AspectRatio(
                aspectRatio: 1.3,
                child: CachedNetworkImage(
                  imageUrl: _occasionProductEntity.image,
                  fit: BoxFit.cover,
                  placeholder: (context, url) =>
                      LoadingIndicator(size: screenWidth * 0.20),
                  errorWidget: (context, url, error) => Center(
                    child: Icon(
                      Icons.image_not_supported,
                      size: screenWidth * 0.14,
                      color: AppColors.lightGrey,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(screenWidth * 0.03),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _occasionProductEntity.name,
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w400,
                      fontSize: fontSize,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: screenHeight * 0.001),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        '${AppTextConstants.egp} ${_occasionProductEntity.priceAfterDiscount}',
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: AppColors.textPrimary,
                              fontSize: screenWidth * 0.039,
                            ),
                      ),
                      SizedBox(width: screenWidth * 0.018),
                      Text(
                        '${_occasionProductEntity.price}',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontSize: fontSize,
                          color: AppColors.textSecondary,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),

                      SizedBox(width: screenWidth * 0.018),

                      Visibility(
                        visible: _occasionProductEntity.discountPercentage != 0,
                        child: Text(
                          '${_occasionProductEntity.discountPercentage}${AppTextConstants.percentageSign}',
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(
                                fontSize: screenWidth * 0.032,
                                color: AppColors.green,
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.03,
              ).copyWith(bottom: screenWidth * 0.02),
              child: SizedBox(
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
                    style: TextStyle(fontSize: fontSize),
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
