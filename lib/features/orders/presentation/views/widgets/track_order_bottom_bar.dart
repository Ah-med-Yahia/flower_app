import 'package:flutter/material.dart';
import 'package:flower_app/core/theme/app_colors.dart';
import 'package:flower_app/core/constants/app_text_constants.dart';
import 'package:flower_app/features/orders/data/models/track_order_model.dart';
import 'package:flower_app/features/orders/presentation/views/screens/track_order_map_screen.dart';

class TrackOrderBottomBar extends StatelessWidget {
  final bool isDelivered;
  final TrackOrderModel order;
  final DriverModel? driver;
  final String userId;
  final String orderId;

  const TrackOrderBottomBar({
    super.key,
    required this.isDelivered,
    required this.order,
    required this.driver,
    required this.userId,
    required this.orderId,
  });

  void _showMap(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) =>
            TrackOrderMapScreen(userId: userId, orderId: orderId),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: AppColors.lightGrey, width: 1)),
      ),
      child: Row(
        children: [
          Expanded(
            child: SizedBox(
              height: 52,
              child: ElevatedButton.icon(
                onPressed: () => _showMap(context),
                icon: const Icon(Icons.map_rounded, size: 20),
                label: Text(AppTextConstants.trackOrderShowMap),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  textStyle: Theme.of(context).textTheme.labelLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
          ),
          if (isDelivered) ...[
            const SizedBox(width: 12),
            Expanded(
              child: SizedBox(
                height: 52,
                child: ElevatedButton(
                  onPressed: () {
                    // Mark as confirmed delivered — pop back or do action
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.textPrimary,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    textStyle: Theme.of(context).textTheme.labelLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                    ),
                  ),
                  child: Text(AppTextConstants.trackOrderDelivered),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
