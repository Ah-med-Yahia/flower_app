import 'package:flower_app/core/theme/app_colors.dart';
import 'package:flower_app/features/checkout/domain/entities/adresses/address_entity.dart';
import 'package:flower_app/features/checkout/presentaion/cubit/checkout_cubit.dart';
import 'package:flower_app/features/checkout/presentaion/cubit/checkout_intents.dart';
import 'package:flower_app/features/checkout/presentaion/cubit/checkout_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddressItem extends StatelessWidget {
  final AddressEntity value;
  final String title;
  final String subtitle;

  const AddressItem({
    super.key,
    required this.value,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CheckoutCubit, CheckoutStates>(
      buildWhen: (prev, curr) => prev.selectedAddress != curr.selectedAddress,
      builder: (context, state) {
        final isSelected = state.selectedAddress == value;

        return InkWell(
          onTap: () {
            context.read<CheckoutCubit>().doIntent(
              SelectDeliveryAddressIntent(value.id!),
            );
          },
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: isSelected
                      ? AppColors.primary.withAlpha(100)
                      : AppColors.grey.withAlpha(75),
                  blurRadius: 4,
                ),
              ],
            ),
            child: Row(
              children: [
                Radio<AddressEntity>(
                  value: value,
                  fillColor: WidgetStateProperty.all(
                    isSelected ? AppColors.primary : AppColors.grey,
                  ),
                ),

                const SizedBox(width: 8),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(
                          context,
                        ).textTheme.titleMedium?.copyWith(fontSize: 18),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        subtitle,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(
                          context,
                        ).textTheme.bodySmall?.copyWith(color: AppColors.grey),
                      ),
                    ],
                  ),
                ),

                IconButton(
                  icon: const Icon(
                    Icons.edit_outlined,
                    color: AppColors.iconGrey,
                  ),
                  onPressed: () {
                    if (value.id != null && value.id!.isNotEmpty) {
                      context.read<CheckoutCubit>().doIntent(
                        EditDeliveryAddressIntent(value.id!),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
