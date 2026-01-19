import 'package:flutter/material.dart';
import 'package:online_exam_app/features/occasion/presentation/views/widgets/product_card.dart';

class ProductsGrid extends StatelessWidget {
  const ProductsGrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Expanded(
      child: GridView.builder(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.64,
          crossAxisSpacing: screenWidth * 0.03,
          mainAxisSpacing: screenWidth * 0.03,
        ),
        itemCount: 6,
        itemBuilder: (context, index) {
          return const ProductCard(
            imageUrl:
                'https://c4.wallpaperflare.com/wallpaper/681/545/122/trees-covered-with-sand-during-daytime-bamberg-bamberg-wallpaper-preview.jpg',
            productName: 'Red roses',
            price: 600,
            originalPrice: 800,
            discount: 20,
            id: '1',
          );
        },
      ),
    );
  }
}
