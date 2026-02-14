import 'package:flower_app/core/theme/app_colors.dart';
import 'package:flower_app/core/ui_utils/ui_utils.dart';
import 'package:flower_app/features/categories/domain/entities/category_products_response_entity/category_product_entity.dart';
import 'package:flower_app/features/categories/presentation/cubit/categories_cubit.dart';
import 'package:flower_app/features/categories/presentation/cubit/categories_state.dart';
import 'package:flower_app/features/categories/presentation/views/widgets/category_product_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryProductsGridWidget extends StatelessWidget {
  final List<CategoryProductEntity> products;

  const CategoryProductsGridWidget({required this.products, super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Expanded(
      child: BlocListener<CategoriesCubit, CategoriesState>(
        listenWhen: (previous, current) =>
            current.productsInCart.errorMessage != null,
        listener: (context, state) {
          if (state.productsInCart.errorMessage != null) {
            UIUtils.showMessage(
              state.productsInCart.errorMessage!,
              backGroundColor: AppColors.red,
              textColor: AppColors.white,
            );
          }
        },
        child: GridView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.65,
            crossAxisSpacing: screenWidth * 0.03,
            mainAxisSpacing: screenWidth * 0.03,
          ),
          physics: const BouncingScrollPhysics(),
          itemCount: products.length,
          itemBuilder: (context, index) {
            return CategoryProductCardWidget(product: products[index]);
          },
        ),
      ),
    );
  }
}
