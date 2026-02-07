import 'dart:async';

import 'package:flower_app/core/constants/app_text_constants.dart';
import 'package:flower_app/core/theme/app_colors.dart';
import 'package:flower_app/core/ui_utils/ui_utils.dart';
import 'package:flower_app/features/checkout/presentaion/cubit/checkout_cubit.dart';
import 'package:flower_app/features/checkout/presentaion/cubit/checkout_intents.dart';
import 'package:flower_app/features/checkout/presentaion/cubit/checkout_ui_intents.dart';
import 'package:flower_app/features/checkout/presentaion/view/widgets/delivery_adress_section.dart';
import 'package:flower_app/features/checkout/presentaion/view/widgets/delivery_time_section.dart';
import 'package:flower_app/features/checkout/presentaion/view/widgets/separator_container.dart';
import 'package:flower_app/features/checkout/presentaion/view/widgets/payment_section.dart';
import 'package:flower_app/features/checkout/presentaion/view/widgets/gift_form_section.dart';
import 'package:flower_app/features/checkout/presentaion/view/widgets/total_price_section.dart';
import 'package:flower_app/features/checkout/presentaion/view/widgets/payment_web_view_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  late CheckoutCubit cubit;
  @override
  void initState() {
    super.initState();
    cubit = context.read<CheckoutCubit>();
    cubit.doIntent(GetAdresses());
    cubit.doIntent(GetOrderDetails());
    cubit.uiIntent.listen((intent) {
      if (!mounted) return;
      _handleUiIntent(intent);
    });
  }

  void _handleUiIntent(CheckoutUiIntents intent) {
    switch (intent) {
      case ShowErrorIntent():
        UIUtils.showMessage(
          intent.message,
          backGroundColor: AppColors.red,
          textColor: AppColors.background,
        );
      case ShowLoadingIntent():
        UIUtils.showLoading(context);
      case HideLoadingIntent():
        UIUtils.hideLoading(context);
      case NavigateToSuccessIntent():
        _onOrderSuccess(AppTextConstants.orderPlacedSuccessfully);
      case NavigateToWebviewIntent():
        _openPaymentWebview(intent.url);
      case NavigateToEditAddressIntent():
        UIUtils.showMessage(
          'Feature coming soon',
          backGroundColor: AppColors.grey,
          textColor: AppColors.background,
        );
      case NavigateToNewAddressIntent():
        UIUtils.showMessage(
          'Feature coming soon',
          backGroundColor: AppColors.grey,
          textColor: AppColors.background,
        );
    }
  }

  void _onOrderSuccess(String message) {
    UIUtils.hideLoading(context);
    UIUtils.showMessage(
      message,
      backGroundColor: AppColors.green,
      textColor: AppColors.background,
    );
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) Navigator.of(context).pop(true);
    });
  }

  void _openPaymentWebview(String url) {
    UIUtils.hideLoading(context);
    Navigator.of(context)
        .push<bool>(
          MaterialPageRoute(
            builder: (_) => PaymentWebViewScreen(initialUrl: url),
          ),
        )
        .then((result) {
          if (mounted && result == true) {
            _onOrderSuccess(AppTextConstants.orderPlacedSuccessfully);
          } else if (mounted) {
            UIUtils.showMessage(
              AppTextConstants.paymentCancelled,
              backGroundColor: AppColors.red,
              textColor: AppColors.background,
            );
          }
        });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: cubit,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            AppTextConstants.checkout,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        body: SingleChildScrollView(
          child: Column(
            children: [
              const DeliveryTimeSection(),
              _divider(),
              const DeliveryAddressesSection(),
              _divider(),
              const PaymentSection(),
              const GiftFormSection(),
              _divider(),
              const TotalPriceSection(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _divider() => const Column(
    children: [
      SizedBox(height: 10),
      SeparatorContainer(),
      SizedBox(height: 10),
    ],
  );
}
