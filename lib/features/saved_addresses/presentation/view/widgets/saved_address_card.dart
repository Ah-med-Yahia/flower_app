import 'package:flower_app/core/theme/app_colors.dart';
import 'package:flower_app/features/saved_addresses/domain/models/saved_addresses_response_entity.dart'
    show AddressEntity;
import 'package:flutter/material.dart';

class SavedAddressCard extends StatelessWidget {
  final AddressEntity address;
  final VoidCallback? onDelete;
  final VoidCallback? onEdit;

  const SavedAddressCard({
    super.key,
    required this.address,
    this.onDelete,
    this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    final titleMedium = Theme.of(context).textTheme.titleMedium;
    final titleSmall = Theme.of(context).textTheme.titleSmall;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: AppColors.grey.withValues(alpha: 0.5),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.location_on_outlined,
                    color: AppColors.black,
                    size: 24,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    address.city,
                    style: titleMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: onDelete,
                    icon: const Icon(
                      Icons.delete,
                      color: AppColors.darkRed,
                      size: 30,
                    ),
                  ),
                  IconButton(
                    onPressed: onEdit,
                    icon: const Icon(
                      Icons.edit,
                      color: AppColors.grey,
                      size: 30,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            '${address.street} - ${address.phone}',
            style: titleSmall!.copyWith(
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
