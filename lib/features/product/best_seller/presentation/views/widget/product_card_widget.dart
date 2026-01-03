import 'package:flower_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/widgets/loading_indicator_widget.dart';
import 'custom_btn_add_card_widget.dart';
import 'custom_product_info_widget.dart';

class ProductCardWidget extends StatelessWidget {
  final String? productName;
  final String? imageUrl;
  final double? price;
  final double? originalPrice;
  final int? discountPercentage;
  final VoidCallback? onAddToCart;

  const ProductCardWidget({
    super.key,
    required this.productName,
    required this.imageUrl,
    required this.price,
    required this.originalPrice,
    required this.discountPercentage,
    required this.onAddToCart,
  });

  Widget _cardView({required Widget child}) {
    return Container(
      width: 163,
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(width: 0.5, color: AppColors.grey),
        // boxShadow: [
        //   BoxShadow(
        //     color: Colors.black.withValues(alpha: 0.05),
        //     blurRadius: 4,
        //     offset: const Offset(0, 2),
        //   ),
        // ],
      ),
      child: Padding(padding: const EdgeInsets.all(8.0), child: child),
    );
  }

  Widget _productImageSection({required double height}) {
    return SizedBox(
      width: double.infinity,
      height: height, //131,
      child: Image.network(
        width: double.infinity,
        height: double.infinity,
        imageUrl ?? '',
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Center(
            child: Icon(Icons.local_florist, size: 48, color: Colors.pink[300]),
          );
        },
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return const Center(child: LoadingIndicator());
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _cardView(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product Image Section
          _productImageSection(
            height: MediaQuery.of(context).size.height * 0.16, //131,
          ),
          const Spacer(),
          // Product Info Section
          CustomProductInfoWidget(
            productName: productName,
            price: price,
            originalPrice: originalPrice,
            discountPercentage: discountPercentage?.toDouble(),
          ),
          const Spacer(),
          // Add to Cart Button - FIXED ELEVATION
          CustomBtnAddCardWidget(onAddToCart: onAddToCart),
        ],
      ),
    );
  }
}
