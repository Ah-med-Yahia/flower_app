import 'package:flower_app/core/theme/app_colors.dart';
import 'package:flower_app/features/checkout/domain/entities/adresses/address_entity.dart';
import 'package:flower_app/features/checkout/presentaion/cubit/checkout_cubit.dart';
import 'package:flower_app/features/checkout/presentaion/cubit/checkout_intents.dart';
import 'package:flower_app/features/checkout/presentaion/cubit/checkout_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddressItem extends StatelessWidget {
  final AddressEntity address;
  final String title;
  final String subtitle;

  const AddressItem({
    super.key,
    required this.address,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CheckoutCubit, CheckoutStates>(
      buildWhen: (prev, curr) => prev.selectedAddress != curr.selectedAddress,
      builder: (context, state) {
        final isSelected = state.selectedAddress == address;

        return InkWell(
          onTap: () {
            context.read<CheckoutCubit>().doIntent(
              SelectDeliveryAddressIntent(address.id!),
            );
          },
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.background,
              border: Border.all(
                color: isSelected ? AppColors.primary : AppColors.grey,
                width: isSelected ? 2 : 1,
              ),
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: isSelected
                      ? AppColors.primary.withAlpha(100)
                      : AppColors.grey.withAlpha(75),
                  blurRadius: 8,
                  spreadRadius: 4,
                ),
              ],
            ),
            child: Row(
              children: [
                Radio<AddressEntity>(
                  value: address,
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
                    if (address.id != null && address.id!.isNotEmpty) {
                      context.read<CheckoutCubit>().doIntent(
                        EditDeliveryAddressIntent(address.id!),
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
