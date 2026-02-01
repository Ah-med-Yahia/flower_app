import 'package:flower_app/config/di/di.dart';
import 'package:flower_app/core/constants/app_text_constants.dart';
import 'package:flower_app/core/theme/app_colors.dart';
import 'package:flower_app/core/widgets/loading_indicator_widget.dart';
import 'package:flower_app/features/categories/presentation/cubit/categories_cubit.dart';
import 'package:flower_app/features/categories/presentation/cubit/categories_event.dart';
import 'package:flower_app/features/categories/presentation/cubit/categories_state.dart';
import 'package:flower_app/features/categories/presentation/views/widgets/category_tab_bar.dart';
import 'package:flower_app/features/categories/presentation/views/widgets/custom_category_app_bar.dart';
import 'package:flower_app/features/categories/presentation/views/widgets/products_grid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoriesTap extends StatelessWidget {
  final String? id;

  const CategoriesTap({super.key, this.id});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          getIt<CategoriesCubit>()
            ..onEvent(GetAllCategories(initialCategoryId: id)),
      child: SafeArea(
        child: Column(
          children: [
            const SearchAndFilterProducts(),
            Expanded(
              child: BlocBuilder<CategoriesCubit, CategoriesState>(
                builder: (context, state) {
                  if (state.categoriesState.isLoading) {
                    return Align(
                      alignment: Alignment.topCenter,
                      child: Text(
                        AppTextConstants.loading,
                        style: Theme.of(context).textTheme.titleMedium!
                            .copyWith(color: AppColors.grey),
                      ),
                    );
                  }

                  if (state.categoriesState.errorMessage != null) {
                    return Align(
                      alignment: Alignment.topCenter,
                      child: Text(
                        state.categoriesState.errorMessage!,
                        style: Theme.of(context).textTheme.titleMedium!
                            .copyWith(color: AppColors.darkRed),
                      ),
                    );
                  }

                  final categories =
                      state.categoriesState.data?.categories ?? [];

                  if (categories.isEmpty) {
                    return Align(
                      alignment: Alignment.topCenter,
                      child: Text(
                        AppTextConstants.noCategoriesAvailable,
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: AppColors.darkRed,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    );
                  }

                  return Column(
                    children: [
                      const SizedBox(height: 8),
                      CategoryTabBar(
                        categories: categories,
                        selectedIndex: state.selectedIndex,
                        onTabSelected: (index) {
                          context.read<CategoriesCubit>().onEvent(
                            SelectCategory(index),
                          );
                        },
                      ),
                      BlocBuilder<CategoriesCubit, CategoriesState>(
                        builder: (context, productState) {
                          if (productState.categoryProductsState.isLoading) {
                            return const Expanded(
                              child: LoadingIndicator(size: 130),
                            );
                          }

                          if (productState.categoryProductsState.errorMessage !=
                              null) {
                            return Center(
                              child: Text(
                                productState
                                    .categoryProductsState
                                    .errorMessage!,
                                style: Theme.of(context).textTheme.titleMedium!
                                    .copyWith(color: AppColors.darkRed),
                              ),
                            );
                          }

                          final categoryProducts =
                              productState.categoryProductsState.data?.products;

                          if (categoryProducts == null) {
                            return Expanded(
                              child: Center(
                                child: Text(
                                  AppTextConstants.noProductsAvailable,
                                  style: Theme.of(context).textTheme.titleLarge!
                                      .copyWith(
                                        color: AppColors.darkRed,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                ),
                              ),
                            );
                          }

                          return ProductsGrid(categoryProducts);
                        },
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
