import 'package:flower_app/features/categories/domain/entities/categories_product_entity.dart';
import 'package:flutter/material.dart';
import 'package:flower_app/features/categories/presentation/views/widgets/product_card.dart';

class ProductsGrid extends StatelessWidget {
  final CategoryProductEntity _categoryProductEntity;

  ProductsGrid(this._categoryProductEntity);

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
