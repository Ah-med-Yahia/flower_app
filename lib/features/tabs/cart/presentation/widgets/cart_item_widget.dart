import 'package:cached_network_image/cached_network_image.dart';
import 'package:flower_app/core/constants/app_text_constants.dart';
import 'package:flower_app/core/theme/app_colors.dart';
import 'package:flower_app/core/shared/presentation/widgets/spacing.dart';
import 'package:flower_app/features/tabs/cart/domain/entities/cart_entity/cart_item_entity.dart';
import 'package:flower_app/features/tabs/cart/presentation/widgets/confirmation_dialog.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CartItemWidget extends StatelessWidget {
  final CartItemEntity item;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;
  final VoidCallback onDelete;

  const CartItemWidget({
    super.key,
    required this.item,
    required this.onIncrement,
    required this.onDecrement,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.sizeOf(context);
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Dismissible(
      key: ValueKey('${item.id}_${item.hashCode}'),
      direction: DismissDirection.endToStart,
      onDismissed: (_) {
        onDelete();
      },
      confirmDismiss: (direction) async {
        final result = await showDialog<bool>(
          context: context,
          builder: (context) => ConfirmationDialog(
            title: AppTextConstants.confirm,
            message: AppTextConstants.deleteThisItem,
          ),
        );
        return result ?? false;
      },
      background: Container(
        padding: const EdgeInsets.only(right: 20),
        alignment: Alignment.centerRight,
        decoration: BoxDecoration(
          color: AppColors.red,
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Icon(
          Icons.delete_outline,
          color: AppColors.background,
          size: 30,
        ),
      ),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.lightGrey.withValues(alpha: 0.5)),
        ),
        padding: const EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: screenSize.width * 0.2,
              height: screenSize.height * 0.1114,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: AppColors.lightPink, // Placeholder background
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: CachedNetworkImage(
                  imageUrl: item.product.imgCover!,
                  fit: BoxFit.cover,
                  errorWidget: (context, url, error) => const Icon(
                    Icons.image_not_supported,
                    color: AppColors.grey,
                  ),
                  placeholder: (context, url) => Shimmer.fromColors(
                    baseColor: AppColors.shimmerBaseColor,
                    highlightColor: AppColors.shimmerHighlightColor,
                    child: Container(
                      width: double.infinity,
                      height: double.infinity,
                      color: AppColors.background,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          item.product.title,
                          style: textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      2.horizontalSpacing,
                      GestureDetector(
                        onTap: () {
                          showDialog<bool>(
                            context: context,
                            builder: (context) => ConfirmationDialog(
                              title: AppTextConstants.confirm,
                              message: AppTextConstants.deleteThisItem,
                              onConfirm: onDelete,
                            ),
                          );
                        },
                        child: const Icon(
                          Icons.delete_outline,
                          color: AppColors.red,
                          size: 24,
                        ),
                      ),
                    ],
                  ),
                  5.verticalSpacing,
                  Text(
                    item.product.description,
                    style: textTheme.bodyMedium?.copyWith(
                      fontSize: 12,
                      color: AppColors.textSecondary,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  12.verticalSpacing,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${AppTextConstants.currencySign} ${item.price}',
                        style: textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        children: [
                          _QuantityButton(
                            icon: Icons.remove,
                            onTap: onDecrement,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: Text(
                              '${item.quantity}',
                              style: textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          _QuantityButton(icon: Icons.add, onTap: onIncrement),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _QuantityButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _QuantityButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(4),
        child: Icon(icon, size: 20, color: AppColors.textPrimary),
      ),
    );
  }
}
