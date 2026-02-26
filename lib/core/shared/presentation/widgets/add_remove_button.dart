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
    if (!productInStock) return const _OutOfStockText();

    final screenSize = MediaQuery.of(context).size;

    return BlocBuilder<ProductsCubit, ProductsState>(
      buildWhen: (previous, current) =>
          previous.pendingCartIds != current.pendingCartIds ||
          previous.productsInCart.data != current.productsInCart.data,
      builder: (context, state) {
        final isInCart =
            state.productsInCart.data?.contains(productId) ?? false;
        final isPending = state.pendingCartIds.contains(productId);

        return _CartButton(
          screenSize: screenSize,
          isInCart: isInCart,
          isPending: isPending,
          onPressed: _onPressed(context, isPending, isInCart),
        );
      },
    );
  }

  VoidCallback? _onPressed(
    BuildContext context,
    bool isPending,
    bool isInCart,
  ) {
    if (isPending) return null;

    final cubit = context.read<ProductsCubit>();

    return () {
      if (isInCart) {
        cubit.onIntent(RemoveProductFromCart(productId));
        return;
      }
      cubit.onIntent(AddProductToCart(productId, 1));
    };
  }
}

class _CartButton extends StatelessWidget {
  const _CartButton({
    required this.screenSize,
    required this.isInCart,
    required this.isPending,
    required this.onPressed,
  });

  final Size screenSize;
  final bool isInCart;
  final bool isPending;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final backgroundColor = isInCart ? AppColors.grey : AppColors.primary;
    final disabledColor = backgroundColor.withValues(alpha: 0.5);

    return ElevatedButton.icon(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        disabledBackgroundColor: disabledColor,
      ),
      icon: Icon(Icons.shopping_cart_outlined, size: screenSize.width * 0.055),
      label: Text(
        isInCart ? AppTextConstants.removeFromCart : AppTextConstants.addToCart,
        style: Theme.of(context).textTheme.labelLarge?.copyWith(
          fontSize: screenSize.width * (isInCart ? 0.032 : 0.035),
          fontWeight: FontWeight.w600,
          color: AppColors.background,
        ),
      ),
    );
  }
}

class _OutOfStockText extends StatelessWidget {
  const _OutOfStockText();

  @override
  Widget build(BuildContext context) {
    return Align(
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
