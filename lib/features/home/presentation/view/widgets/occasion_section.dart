import 'package:flower_app/core/constants/app_text_constants.dart';
import 'package:flower_app/features/home/presentation/view/widgets/best_seller_occations_card_widget.dart';
import 'package:flower_app/features/home/presentation/view/widgets/view_all_button.dart';
import 'package:flower_app/features/home/presentation/view_model/home_screen_cubit.dart';
import 'package:flower_app/features/home/presentation/view_model/home_screen_events.dart';
import 'package:flower_app/features/home/domain/entities/occasion_entity.dart';
import 'package:flutter/material.dart';

class OccasionSection extends StatelessWidget {
  final HomeScreenCubit cubit;
  final List<OccasionEntity> occasions;
  const OccasionSection({
    super.key,
    required this.cubit,
    required this.occasions,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              AppTextConstants.occasion,
              style: textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            ViewAllButton(
              onPressed: () {
                cubit.onEvent(WhenOccasionViewAllIsClickedEvent());
              },
            ),
          ],
        ),
        const SizedBox(height: 8),

        SizedBox(
          height: 195,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: occasions.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: GestureDetector(
                  onTap: () {
                    cubit.onEvent(
                      WhenOccasionIsClickedEvent(
                        occasionId: occasions[index].id,
                      ),
                    );
                  },
                  child: BestSellerOccationsCardWidget(
                    image: occasions[index].image,
                    title: occasions[index].name,
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
