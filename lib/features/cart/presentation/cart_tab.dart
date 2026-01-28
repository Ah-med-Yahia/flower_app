import 'dart:async';
import 'package:flower_app/config/di/di.dart';
import 'package:flower_app/core/constants/app_text_constants.dart';
import 'package:flower_app/core/gen/assets.gen.dart';
import 'package:flower_app/core/theme/app_colors.dart';
import 'package:flower_app/core/ui_utils/ui_utils.dart';
import 'package:flower_app/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:flower_app/features/cart/presentation/cubit/cart_event_ui.dart';
import 'package:flower_app/features/cart/presentation/cubit/cart_intents.dart';
import 'package:flower_app/features/cart/presentation/cubit/cart_states.dart';
import 'package:flower_app/features/cart/presentation/widgets/cart_error_modal_widget.dart';
import 'package:flower_app/features/cart/presentation/widgets/cart_item_widget.dart';
import 'package:flower_app/features/cart/presentation/widgets/cart_lottie_states_widget.dart';
import 'package:flower_app/features/cart/presentation/widgets/cart_summary_widget.dart';
import 'package:flower_app/features/cart/presentation/widgets/clear_cart_modal_widget.dart';
import 'package:flower_app/features/cart/presentation/widgets/location_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

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
  bool _loadingDialogVisible = false;

  @override
  void initState() {
    super.initState();
    _cubit = getIt<CartCubit>();

    _uiSubscription = _cubit.uiEvents.listen((event) {
      if (!mounted) return;
      switch (event) {
        case LoadingCart():
          _handleLoadingUIEvent();
        case Error():
          _handleErrorUIEvent(event.message);
        case SuccessClearCart():
          _handleSuccessClearCartUIEvent();
      }
    });

    _cubit.doIntent(GetCartIntent());
  }

  void _handleLoadingUIEvent() {
    UIUtils.showLoading(context);
    _loadingDialogVisible = true;
    Future.delayed(const Duration(seconds: 1), () {
      if (_loadingDialogVisible) {
        UIUtils.hideLoading(context);
        _loadingDialogVisible = false;
      }
    });
  }

  void _handleErrorUIEvent(String message) {
    if (_loadingDialogVisible) {
      UIUtils.hideLoading(context);
      _loadingDialogVisible = false;
    }
    showCartErrorModal(
      context,
      errorMessage: message,
      onRetry: () {
        _cubit.doIntent(GetCartIntent());
      },
    );
  }

  void _handleSuccessClearCartUIEvent() {
    if (_loadingDialogVisible) {
      UIUtils.hideLoading(context);
      _loadingDialogVisible = false;
    }
    UIUtils.showMessage(
      AppTextConstants.cartClearedSuccessfully,
      backGroundColor: AppColors.green,
      textColor: AppColors.background,
    );
  }

  void showCartErrorModal(
    BuildContext context, {
    required VoidCallback onRetry,
    required String errorMessage,
  }) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return CartErrorModal(onRetry: onRetry, errorMessage: errorMessage);
      },
    );
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
          } else if (state.cartBaseState!.error) {
            return CartLottieStatesWidget(
              lottie: Assets.lottie.cartError.path,
              text: AppTextConstants.cartError,
            );
          } else if (state.cartBaseState!.emptyCart) {
            return CartLottieStatesWidget(
              lottie: Assets.lottie.emptyCart.path,
              text: AppTextConstants.emptyCart,
              textColor: AppColors.primary,
            );
          } else {
            final items = state.cartBaseState!.data!.cart!.cartItems!;
            return SafeArea(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
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
                        SizedBox(
                          height: screenSize.height * .057,
                          width: screenSize.width * .096,
                          child: IconButton(
                            onPressed: () async {
                              showDialog(
                                context: context,
                                barrierDismissible: true,
                                builder: (BuildContext context) {
                                  return ClearCartConfirmationModal(
                                    onConfirm: () async => await _cubit
                                        .doIntent(ClearCartIntent()),
                                  );
                                },
                              );
                            },
                            padding: EdgeInsets.zero,
                            icon: Column(
                              children: [
                                SvgPicture.asset(
                                  Assets.icons.clearCart.path,
                                  width: 24,
                                  height: 24,
                                  colorFilter: ColorFilter.mode(
                                    AppColors.primary,
                                    BlendMode.srcIn,
                                  ),
                                ),
                                Text(
                                  AppTextConstants.clearCart,
                                  style: textStyle.labelSmall!.copyWith(
                                    decoration: TextDecoration.underline,
                                    color: AppColors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: CustomScrollView(
                      slivers: [
                        SliverToBoxAdapter(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16.0,
                              vertical: 12.0,
                            ),
                            child: LocationWidget(),
                          ),
                        ),
                        SliverPadding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          sliver: SliverList(
                            delegate: SliverChildBuilderDelegate((
                              context,
                              index,
                            ) {
                              final item = items[index];
                              return CartItemWidget(
                                key: ValueKey(item.id),
                                item: item,
                                onIncrement: () {
                                  
                                },
                                onDecrement: () {},
                                onDelete: () {},
                              );
                            }, childCount: items.length),
                          ),
                        ),
                      ],
                    ),
                  ),
                  CartSummaryWidget(
                    onCheckout: () => {},
                    key: ValueKey(items.length),
                    deliveryFee: 10,
                    subTotal: state.cartBaseState!.data!.cart!.totalPrice!,
                    total: state.cartBaseState!.data!.cart!.totalPrice! + 10,
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
