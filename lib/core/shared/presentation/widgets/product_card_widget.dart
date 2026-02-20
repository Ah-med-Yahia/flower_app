import 'package:cached_network_image/cached_network_image.dart';
import 'package:flower_app/core/constants/app_routes_constant.dart';
import 'package:flower_app/core/shared/presentation/widgets/add_remove_button.dart';
import 'package:flower_app/core/theme/app_colors.dart';
import 'package:flower_app/core/shared/presentation/widgets/spacing.dart';
import 'package:flower_app/core/shared/domain/entities/products_response_entity/product_entity.dart';
import 'package:flower_app/core/shared/presentation/widgets/product_info_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';

class ProductCardWidget extends StatelessWidget {
  final ProductEntity product;

  const ProductCardWidget({required this.product, super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return InkWell(
      onTap: () {
        context.push(AppRoutesConstants.productDetailsRoute, extra: product.id);
      },
      child: Container(
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.only(top: 6, left: 6, right: 6, bottom: 8),
        decoration: BoxDecoration(
          color: AppColors.grey.withAlpha(30),
          borderRadius: BorderRadius.circular(screenSize.width * 0.03),
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
                    size: screenSize.width * 0.14,
                    color: AppColors.lightGrey,
                  ),
                ),
              ),
            ),
            8.verticalSpacing,
            Expanded(child: ProductInfoWidget(product: product)),
            SizedBox(
              width: double.infinity,
              height: screenSize.height * 0.04,
              child: AddRemoveButton(productId: product.id, productInStock: product.inStock)
            ),
          ],
        ),
      ),
    );
  }
}
