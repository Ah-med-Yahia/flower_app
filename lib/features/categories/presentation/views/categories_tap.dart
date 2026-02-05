import 'package:flower_app/config/di/di.dart';
import 'package:flower_app/core/constants/app_text_constants.dart';
import 'package:flower_app/core/gen/assets.gen.dart';
import 'package:flower_app/core/theme/app_colors.dart';
import 'package:flower_app/core/widgets/loading_indicator_widget.dart';
import 'package:flower_app/core/widgets/spacing.dart';
import 'package:flower_app/features/cart/presentation/widgets/cart_lottie_states_widget.dart';
import 'package:flower_app/features/categories/presentation/cubit/categories_cubit.dart';
import 'package:flower_app/features/categories/presentation/cubit/categories_intents.dart';
import 'package:flower_app/features/categories/presentation/cubit/categories_state.dart';
import 'package:flower_app/features/categories/presentation/views/widgets/category_tab_bar_widget.dart';
import 'package:flower_app/features/categories/presentation/views/widgets/search_and_filter_products_widget.dart';
import 'package:flower_app/features/categories/presentation/views/widgets/products_grid_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoriesTap extends StatelessWidget {
  final String? id;

  const CategoriesTap({super.key, this.id});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return BlocProvider(
      create: (_) =>
          getIt<CategoriesCubit>()
            ..onIntent(GetAllCategories(initialCategoryId: id)),
      child: SafeArea(
        child: Column(
          children: [
            const SearchAndFilterProducts(),
            Expanded(
              child: BlocBuilder<CategoriesCubit, CategoriesState>(
                buildWhen: (previous, current) =>
                    previous.categoriesState != current.categoriesState ||
                    previous.selectedIndexCategoryBar !=
                        current.selectedIndexCategoryBar,
                builder: (context, state) {
                  if (state.categoriesState.isLoading) {
                    return Align(
                      alignment: Alignment.topCenter,
                      child: Text(
                        AppTextConstants.loading,
                        style: textTheme.titleMedium!.copyWith(
                          color: AppColors.grey,
                        ),
                      ),
                    );
                  }
                  if (state.categoriesState.errorMessage != null) {
                    return Align(
                      alignment: Alignment.topCenter,
                      child: Text(
                        state.categoriesState.errorMessage!,
                        style: textTheme.titleMedium!.copyWith(
                          color: AppColors.darkRed,
                        ),
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
                        style: textTheme.titleLarge!.copyWith(
                          color: AppColors.darkRed,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    );
                  }
                  return Column(
                    children: [
                      8.verticalSpacing,
                      CategoryTabBar(
                        categories: categories,
                        selectedIndex: state.selectedIndexCategoryBar,
                        onTabSelected: (index) {
                          context.read<CategoriesCubit>().onIntent(
                            SelectCategory(index),
                          );
                        },
                      ),
                      BlocBuilder<CategoriesCubit, CategoriesState>(
                        buildWhen: (previous, current) =>
                            previous.categoryProductsState !=
                            current.categoryProductsState,
                        builder: (context, productState) {
                          if (productState.categoryProductsState.isLoading) {
                            return const Expanded(
                              child: LoadingIndicator(size: 130),
                            );
                          }
                          if (productState.categoryProductsState.errorMessage !=
                              null) {
                            return LottieStatesWidget(
                              lottie: Assets.lottie.error.path,
                              text: productState
                                  .categoryProductsState
                                  .errorMessage!,
                              textColor: AppColors.primary,
                            );
                          }
                          final categoryProducts =
                              productState.categoryProductsState.data?.products;
                          if (categoryProducts == null ||
                              categoryProducts.isEmpty) {
                            return LottieStatesWidget(
                              lottie: Assets.lottie.emptyBox.path,
                              text: AppTextConstants.noProductsAvailable,
                              textColor: AppColors.primary,
                              height: MediaQuery.of(context).size.height * 0.26,
                            );
                          }
                          return ProductsGridWidget(products: categoryProducts);
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
