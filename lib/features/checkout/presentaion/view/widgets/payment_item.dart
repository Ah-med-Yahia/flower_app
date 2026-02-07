import 'package:flower_app/core/theme/app_colors.dart';
import 'package:flower_app/features/checkout/presentaion/cubit/checkout_cubit.dart';
import 'package:flower_app/features/checkout/presentaion/cubit/checkout_intents.dart';
import 'package:flower_app/features/checkout/presentaion/cubit/checkout_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PaymentItem extends StatelessWidget {
  final String title;
  final String paymentMethod;

  const PaymentItem({
    super.key,
    required this.title,
    required this.paymentMethod,
  });

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<CheckoutCubit>();

    return BlocBuilder<CheckoutCubit, CheckoutStates>(
      buildWhen: (p, c) => p.selectedPaymentMethod != c.selectedPaymentMethod,
      builder: (context, state) {
        final isSelected = state.selectedPaymentMethod == paymentMethod;

        return InkWell(
          onTap: () {
            viewModel.doIntent(SelectPaymentMethodIntent(paymentMethod));
          },
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: isSelected ? AppColors.primary : AppColors.grey,
                width: isSelected ? 2 : 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: isSelected
                      ? AppColors.primary.withAlpha(100)
                      : AppColors.grey.withAlpha(75),
                  blurRadius: isSelected ? 8 : 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: isSelected ? AppColors.primary : Colors.black,
                  ),
                ),
                Radio<String>(
                  value: paymentMethod,
                  fillColor: WidgetStateProperty.all(
                    isSelected ? AppColors.primary : AppColors.grey,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
