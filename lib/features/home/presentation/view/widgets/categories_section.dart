import 'package:flower_app/core/constants/app_text_constants.dart';
import 'package:flower_app/core/theme/app_colors.dart';
import 'package:flower_app/features/home/presentation/view/widgets/category_card_widget.dart';
import 'package:flower_app/features/home/presentation/view/widgets/view_all_button.dart';
import 'package:flower_app/features/home/presentation/view_model/home_screen_cubit.dart';
import 'package:flower_app/features/home/presentation/view_model/home_screen_events.dart';
import 'package:flower_app/features/home/domain/entities/category_entity.dart';
import 'package:flutter/material.dart';

class CategoriesSection extends StatelessWidget {
  const CategoriesSection({
    super.key,
    required this.onNavigateToCategories,
    required this.cubit,
    required this.categories,
  });

  final VoidCallback onNavigateToCategories;
  final HomeScreenCubit cubit;
  final List<CategoryEntity> categories;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              AppTextConstants.categories,
              style: textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            ViewAllButton(onPressed: onNavigateToCategories),
          ],
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 120,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: categories.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  cubit.onEvent(
                    WhenCategoryIsClickedEvent(
                      categoryId: categories[index].id,
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: CategoryCardWidget(
                    imageUrl: categories[index].image,
                    label: categories[index].name,
                    bgColor: AppColors.primary.withValues(alpha: 0.1),
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
