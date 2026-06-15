import 'package:cached_network_image/cached_network_image.dart';
import 'package:flower_app/core/constants/app_routes_constant.dart';
import 'package:flower_app/core/constants/app_text_constants.dart';
import 'package:flower_app/core/shared/presentation/widgets/loading_indicator_widget.dart';
import 'package:flower_app/core/theme/app_colors.dart';
import 'package:flower_app/features/orders/domain/entities/order_entity.dart';
import 'package:flower_app/features/orders/domain/entities/order_item_entity.dart';
import 'package:flower_app/features/orders/domain/entities/order_product_entity.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class OrderCard extends StatelessWidget {
  final OrderEntity order;
  final OrderItemEntity orderItemEntity;
  final OrderProductEntity product;
  final bool isActive;

  const OrderCard({
    super.key,
    required this.order,
    required this.orderItemEntity,
    required this.isActive,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: () {
        if (product.id != null && product.id!.isNotEmpty) {
          context.push(
            AppRoutesConstants.productDetailsRoute,
            extra: product.id,
          );
        }
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.grey, width: 1),
        ),
        child: Row(
          children: [
            CachedNetworkImage(
              imageUrl: product.imgCover!,
              fit: BoxFit.cover,
              width: 120,
              height: 109,
              placeholder: (context, url) => const LoadingIndicator(size: 40),
              errorWidget: (context, url, error) => Icon(
                Icons.local_florist,
                size: 60,
                color: AppColors.grey.withAlpha(120),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.title!,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${AppTextConstants.egp} ${product.priceAfterDiscount!}',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    isActive
                        ? '${AppTextConstants.orderNumber} ${order.orderNumber}'
                        : AppTextConstants.delivered,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: AppColors.grey,
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    height: 40,
                    child: ElevatedButton(
                      onPressed: () {
                        if (isActive) {
                          context.pushNamed(
                            AppRoutesConstants.trackOrderRoute,
                            extra: <String, String>{
                              'userId': '69deac8e6bbaf1588bbc1984',
                              'orderId': '69e182da6bbaf1588bbc86c9',
                            },
                          );
                        }
                      },
                      child: Text(
                        isActive
                            ? AppTextConstants.trackOrder
                            : AppTextConstants.reorder,
                      ),
                    ),
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
