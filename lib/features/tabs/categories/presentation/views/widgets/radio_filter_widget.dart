import 'package:flower_app/core/constants/app_text_constants.dart';
import 'package:flower_app/core/gen/assets.gen.dart';
import 'package:flower_app/core/theme/app_colors.dart';
import 'package:flower_app/core/shared/presentation/widgets/spacing.dart';
import 'package:flower_app/features/tabs/categories/presentation/cubit/categories_cubit.dart';
import 'package:flower_app/features/tabs/categories/presentation/cubit/categories_intents.dart';
import 'package:flower_app/features/tabs/categories/presentation/cubit/categories_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class RadioFilterWidget extends StatelessWidget {
  const RadioFilterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final screenSize = MediaQuery.sizeOf(context);
    return Container(
      height: screenSize.height * 0.7,
      padding: const EdgeInsets.all(16),
      width: double.infinity,

      child: Column(
        children: [
          Container(
            height: 4,
            width: screenSize.width * 0.3,
            decoration: BoxDecoration(
              color: AppColors.darkGrey,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          16.verticalSpacing,

          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              AppTextConstants.sortBy,
              style: textTheme.titleLarge!.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          16.verticalSpacing,
          Expanded(
            child: BlocBuilder<CategoriesCubit, CategoriesState>(
              buildWhen: (previous, current) =>
                  previous.selectedSortOption != current.selectedSortOption,
              builder: (context, state) {
                return RadioGroup<String>(
                  groupValue: state.selectedSortOption,
                  onChanged: (value) {
                    context.read<CategoriesCubit>().onIntent(
                      SelectSortOption(value),
                    );
                  },
                  child: ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: context
                        .read<CategoriesCubit>()
                        .sortOptions
                        .length,
                    separatorBuilder: (_, _) => 16.verticalSpacing,
                    itemBuilder: (context, index) {
                      return RadioListTile(
                        controlAffinity: ListTileControlAffinity.trailing,
                        title: Text(
                          context
                              .read<CategoriesCubit>()
                              .sortOptions
                              .keys
                              .toList()[index],
                          style: textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        value: context
                            .read<CategoriesCubit>()
                            .sortOptions
                            .values
                            .toList()[index],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        fillColor: const WidgetStatePropertyAll(
                          AppColors.primary,
                        ),
                        tileColor: AppColors.white,
                        toggleable: true,
                      );
                    },
                  ),
                );
              },
            ),
          ),
          ElevatedButton(
            onPressed: () {
              context.pop();
              if (context.read<CategoriesCubit>().state.categoryId != null) {
                context.read<CategoriesCubit>().onIntent(
                  GetCategoryProducts(
                    context.read<CategoriesCubit>().state.categoryId!,
                    sortOption: context
                        .read<CategoriesCubit>()
                        .state
                        .selectedSortOption,
                  ),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              fixedSize: Size(screenSize.width * 0.8, screenSize.height * 0.07),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 20,
                  height: 20,
                  child: SvgPicture.asset(
                    Assets.icons.filterIcon.path,
                    colorFilter: const ColorFilter.mode(
                      AppColors.white,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
                3.horizontalSpacing,
                Text(
                  AppTextConstants.filter,
                  style: textTheme.titleMedium?.copyWith(
                    color: AppColors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
