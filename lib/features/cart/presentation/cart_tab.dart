import 'dart:async';
import 'package:flower_app/config/di/di.dart';
import 'package:flower_app/core/constants/app_text_constants.dart';
import 'package:flower_app/core/gen/assets.gen.dart';
import 'package:flower_app/core/theme/app_colors.dart';
import 'package:flower_app/core/ui_utils/ui_utils.dart';
import 'package:flower_app/core/widgets/spacing.dart';
import 'package:flower_app/features/cart/domain/entities/update_item_quantity_request_entity.dart';
import 'package:flower_app/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:flower_app/features/cart/presentation/cubit/cart_event_ui.dart';
import 'package:flower_app/features/cart/presentation/cubit/cart_intents.dart';
import 'package:flower_app/features/cart/presentation/cubit/cart_states.dart';
import 'package:flower_app/features/cart/presentation/widgets/button_clear_cart_widget.dart';
import 'package:flower_app/features/cart/presentation/widgets/cart_error_modal_widget.dart';
import 'package:flower_app/features/cart/presentation/widgets/cart_item_widget.dart';
import 'package:flower_app/features/cart/presentation/widgets/cart_lottie_states_widget.dart';
import 'package:flower_app/features/cart/presentation/widgets/cart_summary_widget.dart';
import 'package:flower_app/features/cart/presentation/widgets/location_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartTab extends StatefulWidget {
  const CartTab({super.key});

  @override
  State<CartTab> createState() => _CartTabState();
}

class _CartTabState extends State<CartTab> {
  late final CartCubit _cubit;
  late final TextTheme textStyle;
  late final Size screenSize;
  StreamSubscription<CartEventUI>? _uiSubscription;

  @override
  void initState() {
    super.initState();
    _cubit = getIt<CartCubit>();

    _uiSubscription = _cubit.uiEvents.listen((event) {
      if (!mounted) return;
      switch (event) {
        case LoadingCart():
          _handleLoadingUIEvent();
        case ErrorGetCart():
          _handleErrorUIEvent(event.message);
        case SuccessAfterLoading():
          _handleSuccessAfterLoading(event.message);
        case ErrorCartItemsUpdate():
          _handleErrorRemoveItemFromCart(event.message);
      }
    });

    _cubit.doIntent(GetCartIntent());
  }

  void _handleLoadingUIEvent() {
    UIUtils.showLoading(context);
  }

  void _handleErrorRemoveItemFromCart(String message) {
    UIUtils.showMessage(
      message,
      backGroundColor: AppColors.red,
      textColor: AppColors.background,
    );
  }

  void _handleErrorUIEvent(String message) {
    UIUtils.hideLoading(context);
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return CartErrorModal(
          onRetry: () => _cubit.doIntent(GetCartIntent()),
          errorMessage: message,
        );
      },
    );
  }

  void _handleSuccessAfterLoading(String? message) {
    UIUtils.hideLoading(context);
    if (message != null) {
      UIUtils.showMessage(
        message,
        backGroundColor: AppColors.green,
        textColor: AppColors.background,
      );
    }
  }

  @override
  void didChangeDependencies() {
    textStyle = Theme.of(context).textTheme;
    screenSize = MediaQuery.of(context).size;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _uiSubscription?.cancel();
    _cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _cubit,
      child: BlocBuilder<CartCubit, CartState>(
        builder: (context, state) {
          if (state.cartBaseState == null) {
            return const SizedBox();
          } else if (state.cartBaseState!.isError) {
            return CartLottieStatesWidget(
              lottie: Assets.lottie.cartError.path,
              text: AppTextConstants.cartError,
            );
          } else if (state.cartBaseState!.isEmpty) {
            return CartLottieStatesWidget(
              lottie: Assets.lottie.emptyCart.path,
              text: AppTextConstants.emptyCart,
              textColor: AppColors.primary,
            );
          } else {
            final cart = state.cartBaseState!.data!.cart;
            final items = cart.cartItems;
            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 16,
                  left: 16,
                  right: 16,
                  bottom: 12,
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          AppTextConstants.cart,
                          style: textStyle.headlineSmall!.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          ' (${items.length} ${AppTextConstants.items})',
                          style: textStyle.headlineSmall,
                        ),
                        const Spacer(),
                        ButtonClearCartWidget(
                          onConfirm: () async {
                            await _cubit.doIntent(ClearCartIntent());
                          },
                        ),
                      ],
                    ),
                    16.verticalSpacing,
                    Expanded(
                      child: CustomScrollView(
                        slivers: [
                          const SliverToBoxAdapter(child: LocationWidget()),
                          SliverToBoxAdapter(child: 16.verticalSpacing),
                          SliverList(
                            delegate: SliverChildBuilderDelegate((
                              context,
                              index,
                            ) {
                              final item = items[index];
                              return CartItemWidget(
                                key: ValueKey('${item.id}_${item.hashCode}'),
                                item: item,
                                onIncrement: () {
                                  _cubit.doIntent(
                                    UpdateItemQuantityIntent(
                                      productId: item.product.productId,
                                      requestEntity:
                                          UpdateItemQuantityRequestEntity(
                                            quantity: item.quantity + 1,
                                          ),
                                    ),
                                  );
                                },
                                onDecrement: () {
                                  if (item.quantity > 1) {
                                    _cubit.doIntent(
                                      UpdateItemQuantityIntent(
                                        productId: item.product.productId,
                                        requestEntity:
                                            UpdateItemQuantityRequestEntity(
                                              quantity: item.quantity - 1,
                                            ),
                                      ),
                                    );
                                  }
                                },
                                onDelete: () async {
                                  await _cubit.doIntent(
                                    RemoveItemFromCartIntent(
                                      productId: item.product.productId,
                                    ),
                                  );
                                },
                              );
                            }, childCount: items.length),
                          ),
                          SliverFillRemaining(
                            hasScrollBody: false,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                const Spacer(),
                                CartSummaryWidget(
                                  onCheckout: () => {
                                    // Todo: implement checkout
                                  },
                                  deliveryFee: cart.deliveryFee,
                                  subTotal: cart.totalPrice,
                                  total: cart.totalPrice + cart.deliveryFee,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
