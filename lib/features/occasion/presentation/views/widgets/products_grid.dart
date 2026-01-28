import 'package:flower_app/features/occasion/domain/entities/occasion_product_entity.dart';
import 'package:flower_app/features/occasion/presentation/views/widgets/product_card.dart';
import 'package:flutter/material.dart';

class ProductsGrid extends StatelessWidget {
  final OccasionProductEntity _occasionProductEntity;

  const ProductsGrid(this._occasionProductEntity, {super.key});

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
