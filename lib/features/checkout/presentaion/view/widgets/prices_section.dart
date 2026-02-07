import 'package:flower_app/core/constants/app_text_constants.dart';
import 'package:flower_app/core/theme/app_colors.dart';
import 'package:flower_app/features/checkout/presentaion/cubit/checkout_cubit.dart';
import 'package:flower_app/features/checkout/presentaion/cubit/checkout_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PricesSection extends StatelessWidget {
  const PricesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CheckoutCubit, CheckoutStates>(
      builder: (context, state) {
        final subtotal = state.cart?.totalPrice?.toDouble() ?? 0.0;
        const deliveryFee = 10.0;
        final total = subtotal + deliveryFee;

        return Column(
          children: [
            _buildPriceRow(
              context,
              label: AppTextConstants.subtotal,
              amount: subtotal,
              color: AppColors.grey,
            ),
            const SizedBox(height: 12),
            _buildPriceRow(
              context,
              label: AppTextConstants.deliveryFee,
              amount: deliveryFee,
              color: AppColors.grey,
            ),
            const SizedBox(height: 16),
            const Divider(thickness: 1, color: AppColors.grey),
            const SizedBox(height: 16),
            _buildPriceRow(
              context,
              label: AppTextConstants.total,
              amount: total,
              color: AppColors.black,
            ),
          ],
        );
      },
    );
  }

  Widget _buildPriceRow(
    BuildContext context, {
    required String label,
    required double amount,
    required Color color,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        Text(
          '${amount.toStringAsFixed(1)} ${AppTextConstants.egp}',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );
  }
}
