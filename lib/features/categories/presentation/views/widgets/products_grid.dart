import 'package:flower_app/features/categories/domain/entities/category_products_response_entity/product_entity.dart';
import 'package:flower_app/features/categories/presentation/views/widgets/product_card.dart';
import 'package:flutter/material.dart';

class ProductsGrid extends StatelessWidget {
  final ProductEntity _categoryProductEntity;

  const ProductsGrid(this._categoryProductEntity, {super.key});

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
        itemCount: 6,
        itemBuilder: (context, index) {
          return ProductCard(_categoryProductEntity);
        },
      ),
    );
  }
}
