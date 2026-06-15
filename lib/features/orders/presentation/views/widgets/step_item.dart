import 'package:flower_app/core/theme/app_colors.dart';
import 'package:flower_app/features/orders/presentation/views/widgets/order_status_stepper.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class StepItem extends StatelessWidget {
  final OrderStatus status;
  final bool isCompleted;
  final bool isLast;
  final DateTime time;

  const StepItem({
    super.key,
    required this.status,
    required this.isCompleted,
    required this.isLast,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final dateStr = DateFormat('dd MMM yyyy - H:mm').format(time);

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 32,
            child: Column(
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 400),
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isCompleted ? AppColors.primary : Colors.transparent,
                    border: Border.all(
                      color: isCompleted
                          ? AppColors.primary
                          : AppColors.lightGrey,
                      width: 2,
                    ),
                  ),
                  child: isCompleted
                      ? const Icon(Icons.circle, size: 8, color: Colors.white)
                      : null,
                ),
                if (!isLast)
                  Expanded(
                    child: Container(
                      width: 2,
                      color: isCompleted
                          ? AppColors.primary
                          : AppColors.lightGrey,
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          // Text column
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 28),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    status.label,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: isCompleted
                          ? AppColors.textPrimary
                          : AppColors.grey,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    dateStr,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: isCompleted ? AppColors.grey : AppColors.lightGrey,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
