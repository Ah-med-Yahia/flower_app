import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flower_app/core/constants/app_text_constants.dart';
import 'package:flower_app/core/theme/app_colors.dart';
import 'package:flower_app/core/widgets/loading_indicator_widget.dart';

class ProductCard extends StatelessWidget {
  final String id;
  final String imageUrl;
  final String productName;
  final int price;
  final int originalPrice;
  final int discount;

  const ProductCard({
    Key? key,
    required this.id,
    required this.imageUrl,
    required this.productName,
    required this.price,
    required this.originalPrice,
    required this.discount,
  }) : super(key: key);

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
                aspectRatio: 1.2,
                child: CachedNetworkImage(
                  imageUrl: imageUrl,
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
                    productName,
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w400,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: screenHeight * 0.001),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        '${AppTextConstants.egp} $price',
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(
                              fontWeight: FontWeight.w500,
                              color: AppColors.textPrimary,
                            ),
                      ),
                      SizedBox(width: screenWidth * 0.019),
                      Text(
                        '$originalPrice',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontSize: fontSize,
                          color: AppColors.textSecondary,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),

                      SizedBox(width: screenWidth * 0.019),

                      Text(
                        '$discount${AppTextConstants.percentageSign}',
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
                  label: Text(AppTextConstants.addToCart),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
