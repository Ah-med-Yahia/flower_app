import 'package:cached_network_image/cached_network_image.dart';
import 'package:flower_app/features/categories/domain/entities/categories_product_entity.dart';
import 'package:flutter/material.dart';
import 'package:flower_app/core/constants/app_text_constants.dart';
import 'package:flower_app/core/theme/app_colors.dart';
import 'package:flower_app/core/widgets/loading_indicator_widget.dart';

class ProductCard extends StatelessWidget {
  final CategoryProductEntity _categoryProductEntity;

  const ProductCard(this._categoryProductEntity);

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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(screenWidth * 0.03),

              child: AspectRatio(
                aspectRatio: 1.2,
                child: CachedNetworkImage(
                  imageUrl: _categoryProductEntity.image,
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
                    _categoryProductEntity.name,
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
                        '${AppTextConstants.egp} ${_categoryProductEntity.priceAfterDiscount}',
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: AppColors.textPrimary,
                              fontSize: screenWidth * 0.039,
                            ),
                      ),
                      SizedBox(width: screenWidth * 0.018),
                      Text(
                        '${_categoryProductEntity.price}',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontSize: fontSize,
                          color: AppColors.textSecondary,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),

                      SizedBox(width: screenWidth * 0.018),

                      Text(
                        '${100 - (_categoryProductEntity.priceAfterDiscount / _categoryProductEntity.price * 100).toInt()}${AppTextConstants.percentageSign}',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontSize: screenWidth * 0.032,
                          color: AppColors.green,
                          fontWeight: FontWeight.w600,
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
