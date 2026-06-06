import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flower_app/core/constants/app_text_constants.dart';
import 'package:flower_app/core/theme/app_colors.dart';
import 'package:flower_app/features/orders/data/models/track_order_model.dart';
import 'package:flower_app/features/orders/presentation/views/widgets/driver_info_card.dart';
import 'package:flower_app/features/orders/presentation/views/widgets/order_status_stepper.dart';
import 'package:flower_app/features/orders/presentation/views/widgets/track_order_bottom_bar.dart';
import 'package:flower_app/features/orders/presentation/views/widgets/track_order_car_illustration.dart';
import 'package:flower_app/features/orders/presentation/views/widgets/track_order_section_card.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TrackOrderScreen extends StatelessWidget {
  final String userId;
  final String orderId;

  const TrackOrderScreen({
    super.key,
    required this.userId,
    required this.orderId,
  });

  static const _defaultUserId = '69deac8e6bbaf1588bbc1984';
  static const _defaultOrderId = '69e182da6bbaf1588bbc86c9';

  @override
  Widget build(BuildContext context) {
    final path =
        'users/${userId.isEmpty ? _defaultUserId : userId}/orders/${orderId.isEmpty ? _defaultOrderId : orderId}';

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(AppTextConstants.trackOrderTitle),
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance.doc(path).snapshots(),
        builder: (context, orderSnapshot) {
          if (orderSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.primary),
            );
          }

          if (orderSnapshot.hasError) {
            return Center(
              child: Text(
                '${AppTextConstants.trackOrderError}: ${orderSnapshot.error}',
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(color: AppColors.red),
              ),
            );
          }

          if (!orderSnapshot.hasData || !orderSnapshot.data!.exists) {
            return Center(
              child: Text(
                AppTextConstants.trackOrderNotFound,
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(color: AppColors.grey),
              ),
            );
          }

          final data = orderSnapshot.data!.data() as Map<String, dynamic>;
          final order = TrackOrderModel.fromMap(data);

          DateTime baseTime;
          try {
            baseTime = DateTime.parse(order.createdAt.replaceAll(' ', 'T'));
          } catch (_) {
            baseTime = DateTime.now();
          }

          final estimatedArrival = baseTime.add(const Duration(hours: 4));
          final arrivalStr = DateFormat(
            'dd MMM yyyy, hh:mm a',
          ).format(estimatedArrival);

          final isDelivered = order.state.toLowerCase() == 'delivered';
          final driver = order.driver;

          return Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 16,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TrackOrderSectionCard(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppTextConstants.trackOrderEstimatedArrival,
                              style: Theme.of(context).textTheme.bodySmall
                                  ?.copyWith(
                                    fontSize: 13,
                                    color: AppColors.textSecondary,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              arrivalStr,
                              style: Theme.of(context).textTheme.titleMedium
                                  ?.copyWith(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.textPrimary,
                                  ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),

                      if (driver != null)
                        DriverInfoCard(
                          name: driver.fullName,
                          photoUrl: driver.photo,
                          phone: driver.phone,
                        ),
                      if (driver == null) _buildDefaultDriverCard(context),
                      const SizedBox(height: 24),
                      Center(
                        child: TrackOrderCarIllustration(state: order.state),
                      ),
                      const SizedBox(height: 24),
                      OrderStatusStepper(
                        currentState: order.state,
                        baseTime: baseTime,
                      ),
                    ],
                  ),
                ),
              ),
              // ---- Bottom buttons ----
              TrackOrderBottomBar(
                isDelivered: isDelivered,
                order: order,
                driver: driver,
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildDefaultDriverCard(BuildContext context) {
    return DriverInfoCard(
      name: AppTextConstants.trackOrderDefaultDriverName,
      photoUrl: 'https://flower.elevateegy.com/uploads/default-profile.png',
      phone: '+201091391966',
    );
  }
}
