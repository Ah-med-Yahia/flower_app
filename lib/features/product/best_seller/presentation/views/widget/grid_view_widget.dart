import 'package:flower_app/features/product/best_seller/presentation/view_models/best_seller_events.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/constants/app_text_constants.dart';
import '../../view_models/best_seller_cubit.dart';
import 'product_card_widget.dart';

class GridViewWidget extends StatelessWidget {
  const GridViewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<BestSellerCubit>();
    final productItem = cubit.state.bestSellerList ?? [];
    if (productItem.isEmpty) {
      return const Center(child: Text(AppTextConstants.noProductsAvailable));
    }

    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        childAspectRatio: 0.64,
      ),
      itemCount: productItem.length,
      itemBuilder: (context, index) {
        final product = productItem[index];
        final price = product.priceAfterDiscount?.toDouble();
        final originalPrice = product.price?.toDouble();
        final discountRate =
            (originalPrice != null && price != null && originalPrice > 0)
            ? ((originalPrice - price) / originalPrice) * 100
            : 0.0;
        return InkWell(
          onTap: () {
            cubit.doIntent(
              NavigateToProductDetailsEvent(productId: product.id ?? ''),
            );
          },
          child: ProductCardWidget(
            productName: product.title,
            imageUrl: product.imgCover,
            price: price,
            originalPrice: originalPrice,
            discountPercentage: discountRate.toInt(),
            onAddToCart: () {},
          ),
        );
      },
    );
  }
}
