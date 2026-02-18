import 'package:flower_app/core/constants/app_text_constants.dart';
import 'package:flower_app/core/shared/domain/entities/products_response_entity/product_entity.dart';
import 'package:flower_app/features/tabs/home/presentation/view/widgets/best_seller_occations_card_widget.dart';
import 'package:flower_app/features/tabs/home/presentation/view/widgets/view_all_button.dart';
import 'package:flower_app/features/tabs/home/presentation/view_model/home_screen_cubit.dart';
import 'package:flower_app/features/tabs/home/presentation/view_model/home_screen_events.dart';
import 'package:flutter/material.dart';

class BestSellerSection extends StatelessWidget {
  const BestSellerSection({
    super.key,
    required this.cubit,
    required this.bestSeller,
  });

  final HomeScreenCubit cubit;
  final List<ProductEntity> bestSeller;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              AppTextConstants.bestSeller,
              style: textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            ViewAllButton(
              onPressed: () {
                cubit.onEvent(WhenViewAllBestSellerIsClickedEvent());
              },
            ),
          ],
        ),
        SizedBox(
          height: 220,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: bestSeller.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: GestureDetector(
                  onTap: () {
                    cubit.onEvent(
                      WhenBestSellerIsClickedEvent(
                        productId: bestSeller[index].id,
                      ),
                    );
                  },
                  child: BestSellerOccationsCardWidget(
                    image: bestSeller[index].imageCover ?? '',
                    title: bestSeller[index].title,
                    price: bestSeller[index].priceAfterDiscount?.toString(),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
