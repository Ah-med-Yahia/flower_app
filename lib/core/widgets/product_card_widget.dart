import 'package:cached_network_image/cached_network_image.dart';
import 'package:flower_app/core/constants/app_routes_constant.dart';
import 'package:flower_app/core/constants/app_text_constants.dart';
import 'package:flower_app/core/shared/presentation/cubits/products_cubit/products_cubit.dart';
import 'package:flower_app/core/shared/presentation/cubits/products_cubit/products_intents.dart';
import 'package:flower_app/core/shared/presentation/cubits/products_cubit/products_state.dart';
import 'package:flower_app/core/theme/app_colors.dart';
import 'package:flower_app/core/widgets/spacing.dart';
import 'package:flower_app/core/shared/domain/entities/products_response_entity/product_entity.dart';
import 'package:flower_app/core/widgets/product_info_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';

class ProductCardWidget extends StatelessWidget {
  final ProductEntity product;

  const ProductCardWidget({required this.product, super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return InkWell(
      onTap: () {
        context.push(AppRoutesConstants.productDetailsRoute, extra: product.id);
      },
      child: Container(
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.only(top: 6, left: 6, right: 6, bottom: 8),
        decoration: BoxDecoration(
          color: AppColors.grey.withAlpha(30),
          borderRadius: BorderRadius.circular(screenSize.width * 0.03),
          border: Border.all(color: AppColors.grey, width: 0.5),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 1.2,
              child: CachedNetworkImage(
                imageUrl: product.imageCover ?? '',
                fit: BoxFit.cover,
                placeholder: (_, _) => Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    width: double.infinity,
                    height: 200.0,
                    color: Colors.white,
                  ),
                ),
                errorWidget: (_, _, _) => Center(
                  child: Icon(
                    Icons.image_not_supported,
                    size: screenSize.width * 0.14,
                    color: AppColors.lightGrey,
                  ),
                ),
              ),
            ),
            8.verticalSpacing,
            Expanded(child: ProductInfoWidget(product: product)),
            SizedBox(
              width: double.infinity,
              height: screenSize.height * 0.04,
              child: product.inStock
                  ? BlocBuilder<ProductsCubit, ProductsState>(
                      buildWhen: (previous, current) {
                        return previous.pendingCartIds !=
                                current.pendingCartIds ||
                            previous.productsInCart.data !=
                                current.productsInCart.data;
                      },
                      builder: (context, state) {
                        final isInCart =
                            state.productsInCart.data?.contains(product.id) ??
                            false;
                        final isPending = state.pendingCartIds.contains(
                          product.id,
                        );
                        return ElevatedButton.icon(
                          onPressed: isPending
                              ? null
                              : () {
                                  isInCart
                                      ? context.read<ProductsCubit>().onIntent(
                                          RemoveProductFromCart(product.id),
                                        )
                                      : context.read<ProductsCubit>().onIntent(
                                          AddProductToCart(product.id, 1),
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
                            style: Theme.of(context).textTheme.labelLarge
                                ?.copyWith(
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
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
