import 'package:flower_app/core/constants/app_text_constants.dart';
import 'package:flower_app/core/theme/app_colors.dart';
import 'package:flower_app/features/checkout/domain/entities/adresses/address_entity.dart';
import 'package:flower_app/features/checkout/presentaion/cubit/checkout_cubit.dart';
import 'package:flower_app/features/checkout/presentaion/cubit/checkout_intents.dart';
import 'package:flower_app/features/checkout/presentaion/cubit/checkout_states.dart';
import 'package:flower_app/features/checkout/presentaion/view/widgets/add_new_adress_button.dart';
import 'package:flower_app/features/checkout/presentaion/view/widgets/adress_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

class DeliveryAddressesSection extends StatelessWidget {
  const DeliveryAddressesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CheckoutCubit>();

    return BlocBuilder<CheckoutCubit, CheckoutStates>(
      buildWhen: (prev, curr) =>
          prev.addresses != curr.addresses ||
          prev.selectedAddress != curr.selectedAddress ||
          prev.isLoading != curr.isLoading,
      builder: (context, state) {
        final isLoading = state.isLoading;
        final addresses = isLoading && state.addresses.isEmpty
            ? List.generate(2, (_) => AddressEntity.fake())
            : state.addresses;

        return Container(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
          color: AppColors.background,

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                AppTextConstants.deliveryAddress,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Skeletonizer(
                enabled: isLoading,
                child: RadioGroup<AddressEntity>(
                  groupValue: state.selectedAddress,
                  onChanged: (address) {
                    if (address!.id != null && address.id!.isNotEmpty) {
                      cubit.doIntent(SelectDeliveryAddressIntent(address.id!));
                    }
                  },
                  child: ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: addresses.length,
                    separatorBuilder: (_, _) => const SizedBox(height: 16),
                    itemBuilder: (context, index) {
                      final address = addresses[index];
                      return AddressItem(
                        address: address,
                        title: '${address.street}',
                        subtitle: '${address.street}, ${address.city}',
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const AddNewAddressButton(),
            ],
          ),
        );
      },
    );
  }
}
