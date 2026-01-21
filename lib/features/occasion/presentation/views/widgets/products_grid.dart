import 'package:flower_app/features/occasion/domain/entities/occasion_product_entity.dart';
import 'package:flutter/material.dart';
import 'package:flower_app/features/occasion/presentation/views/widgets/product_card.dart';

class ProductsGrid extends StatelessWidget {
  final OccasionProductEntity _occasionProductEntity;

  ProductsGrid(this._occasionProductEntity);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Expanded(
      child: GridView.builder(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.67,
          crossAxisSpacing: screenWidth * 0.03,
          mainAxisSpacing: screenWidth * 0.03,
        ),
        itemCount: 6,
        itemBuilder: (context, index) {
          return ProductCard(_occasionProductEntity);
        },
      ),
    );
  }
}
