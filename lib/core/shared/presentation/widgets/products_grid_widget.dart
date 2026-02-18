import 'package:flower_app/core/shared/domain/entities/products_response_entity/product_entity.dart';
import 'package:flower_app/core/shared/presentation/widgets/product_card_widget.dart';
import 'package:flutter/material.dart';

class ProductsGridWidget extends StatelessWidget {
  final List<ProductEntity> products;

  const ProductsGridWidget({
    required this.products,
    super.key,
    this.physics,
    this.shrinkWrap,
    this.padding,
  });

  final ScrollPhysics? physics;
  final bool? shrinkWrap;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return GridView.builder(
      padding: padding ?? const EdgeInsets.symmetric(horizontal: 16),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.65,
        crossAxisSpacing: screenWidth * 0.03,
        mainAxisSpacing: screenWidth * 0.03,
      ),
      physics: physics ?? const BouncingScrollPhysics(),
      shrinkWrap: shrinkWrap ?? false,
      itemCount: products.length,
      itemBuilder: (context, index) {
        return ProductCardWidget(product: products[index]);
      },
    );
  }
}
