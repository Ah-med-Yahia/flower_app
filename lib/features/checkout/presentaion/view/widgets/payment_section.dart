import 'package:flower_app/core/constants/app_text_constants.dart';
import 'package:flower_app/core/theme/app_colors.dart';
import 'package:flower_app/features/checkout/presentaion/cubit/checkout_cubit.dart';
import 'package:flower_app/features/checkout/presentaion/cubit/checkout_intents.dart';
import 'package:flower_app/features/checkout/presentaion/cubit/checkout_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'payment_item.dart';

class PaymentSection extends StatelessWidget {
  const PaymentSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CheckoutCubit, CheckoutStates>(
      buildWhen: (prev, curr) =>
          prev.selectedPaymentMethod != curr.selectedPaymentMethod,
      builder: (BuildContext context, CheckoutStates state) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
          color: AppColors.background,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppTextConstants.paymentMethod,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              RadioGroup(
                groupValue: state.selectedPaymentMethod,
                onChanged: (value) {
                  context.read<CheckoutCubit>().doIntent(
                    SelectPaymentMethodIntent(value!),
                  );
                },
                child: Column(
                  children: [
                    PaymentItem(
                      title: AppTextConstants.cashOnDelivery,
                      paymentMethod: AppTextConstants.cash,
                    ),
                    const SizedBox(height: 16),
                    PaymentItem(
                      title: AppTextConstants.creditCard,
                      paymentMethod: AppTextConstants.credit,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
