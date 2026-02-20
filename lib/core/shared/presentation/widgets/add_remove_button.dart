import 'package:flower_app/core/constants/app_text_constants.dart';
import 'package:flower_app/core/shared/presentation/cubits/products_cubit/products_cubit.dart';
import 'package:flower_app/core/shared/presentation/cubits/products_cubit/products_intents.dart';
import 'package:flower_app/core/shared/presentation/cubits/products_cubit/products_state.dart';
import 'package:flower_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddRemoveButton extends StatelessWidget {
  const AddRemoveButton({
    super.key,
    required this.productId,
    required this.productInStock,
  });

  final String productId;
  final bool productInStock;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return productInStock
        ? BlocBuilder<ProductsCubit, ProductsState>(
            buildWhen: (previous, current) {
              return previous.pendingCartIds != current.pendingCartIds ||
                  previous.productsInCart.data != current.productsInCart.data;
            },
            builder: (context, state) {
              final isInCart =
                  state.productsInCart.data?.contains(productId) ?? false;
              final isPending = state.pendingCartIds.contains(productId);
              return ElevatedButton.icon(
                onPressed: isPending
                    ? null
                    : () {
                        isInCart
                            ? context.read<ProductsCubit>().onIntent(
                                RemoveProductFromCart(productId),
                              )
                            : context.read<ProductsCubit>().onIntent(
                                AddProductToCart(productId, 1),
                              );
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor: isInCart
                      ? AppColors.grey
                      : AppColors.primary,
                  disabledBackgroundColor: isInCart
                      ? AppColors.grey.withValues(alpha: 0.5)
                      : AppColors.primary.withValues(alpha: 0.5),
                ),
                icon: Icon(
                  Icons.shopping_cart_outlined,
                  size: screenSize.width * 0.055,
                ),
                label: Text(
                  isInCart
                      ? AppTextConstants.removeFromCart
                      : AppTextConstants.addToCart,
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    fontSize: isInCart
                        ? screenSize.width * 0.032
                        : screenSize.width * 0.035,
                    fontWeight: FontWeight.w600,
                    color: AppColors.background,
                  ),
                ),
              );
            },
          )
        : Align(
            alignment: Alignment.center,
            child: Text(
              AppTextConstants.outOfStock,
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                fontWeight: FontWeight.w600,
                color: AppColors.red,
              ),
            ),
          );
  }
}
