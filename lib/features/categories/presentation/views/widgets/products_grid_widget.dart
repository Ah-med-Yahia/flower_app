import 'package:flower_app/features/categories/domain/entities/category_products_response_entity/product_entity.dart';
import 'package:flower_app/features/categories/presentation/views/widgets/product_card_widget.dart';
import 'package:flutter/material.dart';

class ProductsGridWidget extends StatelessWidget {
  final List<ProductEntity> products;

  const ProductsGridWidget({required this.products, super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Expanded(
      child: GridView.builder(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.65,
          crossAxisSpacing: screenWidth * 0.03,
          mainAxisSpacing: screenWidth * 0.03,
        ),
        itemCount: products.length,
        itemBuilder: (context, index) {
          return ProductCardWidget(product: products[index]);
        },
      ),
    );
  }
}
