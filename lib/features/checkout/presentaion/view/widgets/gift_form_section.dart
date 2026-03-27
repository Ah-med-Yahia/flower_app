import 'package:flower_app/core/constants/app_text_constants.dart';
import 'package:flower_app/core/theme/app_colors.dart';
import 'package:flower_app/features/checkout/presentaion/cubit/checkout_cubit.dart';
import 'package:flower_app/features/checkout/presentaion/cubit/checkout_intents.dart';
import 'package:flower_app/features/checkout/presentaion/cubit/checkout_states.dart';
import 'package:flower_app/features/checkout/presentaion/view/widgets/is_gift_form.dart';
import 'package:flower_app/features/checkout/presentaion/view/widgets/separator_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GiftFormSection extends StatelessWidget {
  const GiftFormSection({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CheckoutCubit>();
    return BlocBuilder<CheckoutCubit, CheckoutStates>(
      buildWhen: (prev, curr) =>
          prev.selectedPaymentMethod != curr.selectedPaymentMethod ||
          prev.isGift != curr.isGift,
      builder: (context, state) {
        // Only show the gift section when credit card payment is selected
        final bool isVisible =
            state.selectedPaymentMethod == AppTextConstants.credit;

        return AnimatedSize(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          child: isVisible
              ? Column(
                  children: [
                    const SizedBox(height: 10),
                    const SeparatorContainer(),
                    const SizedBox(height: 10),
                    Container(
                      margin: const EdgeInsets.only(bottom: 16.0),
                      padding: const EdgeInsets.symmetric(
                        vertical: 24,
                        horizontal: 16,
                      ),
                      color: AppColors.background,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListTile(
                            visualDensity: const VisualDensity(vertical: -4),
                            onTap: () {
                              cubit.doIntent(
                                ToggleGiftOptionIntent(!state.isGift),
                              );
                            },
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100),
                            ),
                            contentPadding: EdgeInsets.zero,
                            leading: Switch(
                              value: state.isGift,
                              onChanged: (val) =>
                                  cubit.doIntent(ToggleGiftOptionIntent(val)),
                              thumbColor: WidgetStateProperty.resolveWith((
                                states,
                              ) {
                                if (states.contains(WidgetState.selected)) {
                                  return AppColors.primary;
                                }
                                return AppColors.background;
                              }),
                              trackColor: WidgetStateProperty.resolveWith((
                                states,
                              ) {
                                if (states.contains(WidgetState.selected)) {
                                  return AppColors.primary.withValues(
                                    alpha: 0.4,
                                  );
                                }
                                return AppColors.grey.withValues(alpha: 0.3);
                              }),
                              trackOutlineColor: WidgetStateProperty.all(
                                AppColors.primary.withValues(alpha: 0.1),
                              ),
                            ),
                            title: Text(
                              AppTextConstants.itIsAGift,
                              style: Theme.of(context).textTheme.titleLarge
                                  ?.copyWith(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ),

                          AnimatedSize(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                            child: state.isGift
                                ? const IsGiftForm()
                                : const SizedBox.shrink(),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              : const SizedBox(height: 5),
        );
      },
    );
  }
}
