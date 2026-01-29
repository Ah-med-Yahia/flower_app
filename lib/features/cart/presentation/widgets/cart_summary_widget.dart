import 'package:flower_app/core/constants/app_text_constants.dart';
import 'package:flower_app/core/theme/app_colors.dart';
import 'package:flower_app/core/widgets/spacing.dart';
import 'package:flutter/material.dart';

class CartSummaryWidget extends StatelessWidget {
  final int subTotal;
  final int deliveryFee;
  final int total;
  final VoidCallback onCheckout;

  const CartSummaryWidget({
    super.key,
    required this.subTotal,
    required this.deliveryFee,
    required this.total,
    required this.onCheckout,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SummaryRow(
          label: AppTextConstants.subTotal,
          value: '$subTotal${AppTextConstants.dollarSign}',
        ),
        const SizedBox(height: 8),
        SummaryRow(
          label: AppTextConstants.deliveryFee,
          value: '$deliveryFee${AppTextConstants.dollarSign}',
        ),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 12),
          child: Divider(color: AppColors.lightGrey),
        ),
        SummaryRow(
          label: AppTextConstants.total,
          value: '$total${AppTextConstants.dollarSign}',
          isTotal: true,
        ),
        20.verticalSpacing,
        SizedBox(
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.07,
          child: ElevatedButton(
            onPressed: onCheckout,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: AppColors.background,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25), // Pill shape
              ),
              elevation: 0,
            ),
            child: Text(
              AppTextConstants.checkout,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.background,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class SummaryRow extends StatelessWidget {
  final String label;
  final String value;
  final bool isTotal;

  const SummaryRow({
    super.key,
    required this.label,
    required this.value,
    this.isTotal = false,
  });

  @override
  Widget build(BuildContext context) {
    final TextTheme textStyle = Theme.of(context).textTheme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: textStyle.bodyMedium!.copyWith(
            fontSize: isTotal ? 18 : 14,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            color: AppColors.textPrimary,
          ),
        ),
        Text(
          value,
          style: textStyle.bodyMedium!.copyWith(
            fontSize: isTotal ? 18 : 14,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            color: AppColors.textPrimary,
          ),
        ),
      ],
    );
  }
}
