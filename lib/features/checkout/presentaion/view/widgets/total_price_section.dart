import 'package:flower_app/core/constants/app_text_constants.dart';
import 'package:flower_app/core/theme/app_colors.dart';
import 'package:flower_app/features/checkout/presentaion/cubit/checkout_cubit.dart';
import 'package:flower_app/features/checkout/presentaion/cubit/checkout_intents.dart';
import 'package:flower_app/features/checkout/presentaion/cubit/checkout_states.dart';
import 'package:flower_app/features/checkout/presentaion/view/widgets/prices_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TotalPriceSection extends StatelessWidget {
  const TotalPriceSection({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<CheckoutCubit>();
    return BlocBuilder<CheckoutCubit, CheckoutStates>(
      builder: (context, state) {
        final isLoading = state.isLoading;

        return Container(
          padding: const EdgeInsets.only(
            top: 24,
            right: 16,
            left: 16,
            bottom: 64,
          ),
          color: AppColors.background,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const PricesSection(),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: isLoading
                    ? null
                    : () {
                        viewModel.doIntent(PlaceOrderIntent());
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: AppColors.background,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 2,
                ),
                child: isLoading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            AppColors.background,
                          ),
                        ),
                      )
                    : Text(
                        AppTextConstants.placeOrder,
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: AppColors.background,
                            ),
                      ),
              ),
            ],
          ),
        );
      },
    );
  }
}
