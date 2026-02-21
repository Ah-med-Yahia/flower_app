import 'dart:async';

import 'package:flower_app/core/constants/app_routes_constant.dart';
import 'package:flower_app/core/constants/app_text_constants.dart';
import 'package:flower_app/core/shared/domain/entities/products_response_entity/product_entity.dart';
import 'package:flower_app/core/shared/presentation/cubits/products_cubit/products_cubit.dart';
import 'package:flower_app/core/shared/presentation/cubits/products_cubit/products_side_effect.dart';
import 'package:flower_app/core/shared/presentation/widgets/product_card_widget.dart';
import 'package:flower_app/features/tabs/cart/presentation/widgets/confirmation_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ProductsGridWidget extends StatefulWidget {
  final List<ProductEntity> products;

  const ProductsGridWidget({
    required this.products,
    super.key,
    this.physics,
    this.shrinkWrap,
    this.padding,
  });

  final ScrollPhysics? physics;
  final bool? shrinkWrap;
  final EdgeInsets? padding;

  @override
  State<ProductsGridWidget> createState() => _ProductsGridWidgetState();
}

class _ProductsGridWidgetState extends State<ProductsGridWidget> {
  late StreamSubscription<ProductsSideEffect> _sideEffectSubscription;
  @override
  void initState() {
    super.initState();
    _sideEffectSubscription = context
        .read<ProductsCubit>()
        .sideEffectStream
        .listen((event) {
          if (event is LogoutUser) {
            _handleLogoutUser();
          }
        });
  }

  void _handleLogoutUser() {
    showDialog(
      context: context,
      builder: (context) {
        return ConfirmationDialog(
          message: AppTextConstants.mustLogin,
          icon: Icons.warning,
          onConfirm: () {
            context.pushNamed(AppRoutesConstants.loginRoute);
          },
          title: AppTextConstants.attention,
        );
      },
    );
  }

  @override
  void dispose() {
    _sideEffectSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return GridView.builder(
      padding: widget.padding ?? const EdgeInsets.symmetric(horizontal: 16),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.65,
        crossAxisSpacing: screenWidth * 0.03,
        mainAxisSpacing: screenWidth * 0.03,
      ),
      physics: widget.physics ?? const BouncingScrollPhysics(),
      shrinkWrap: widget.shrinkWrap ?? false,
      itemCount: widget.products.length,
      itemBuilder: (context, index) {
        return ProductCardWidget(product: widget.products[index]);
      },
    );
  }
}
