import 'package:flower_app/core/constants/app_text_constants.dart';
import 'package:flower_app/features/orders/presentation/views/widgets/step_item.dart';
import 'package:flutter/material.dart';

enum OrderStatus { accepted, picked, outForDelivery, delivered }

extension OrderStatusExt on OrderStatus {
  String get label {
    switch (this) {
      case OrderStatus.accepted:
        return AppTextConstants.trackOrderReceivedYourOrder;
      case OrderStatus.picked:
        return AppTextConstants.trackOrderPreparingYourOrder;
      case OrderStatus.outForDelivery:
        return AppTextConstants.trackOrderOutForDelivery;
      case OrderStatus.delivered:
        return AppTextConstants.delivered;
    }
  }

  String get firestoreValue {
    switch (this) {
      case OrderStatus.accepted:
        return 'Accepted';
      case OrderStatus.picked:
        return 'Picked';
      case OrderStatus.outForDelivery:
        return 'Out for delivery';
      case OrderStatus.delivered:
        return 'Delivered';
    }
  }

  static OrderStatus fromString(String value) {
    switch (value.toLowerCase()) {
      case 'accepted':
        return OrderStatus.accepted;
      case 'picked':
        return OrderStatus.picked;
      case 'out for delivery':
        return OrderStatus.outForDelivery;
      case 'delivered':
        return OrderStatus.delivered;
      default:
        return OrderStatus.accepted;
    }
  }
}

class OrderStatusStepper extends StatelessWidget {
  final String currentState;
  final DateTime baseTime;

  const OrderStatusStepper({
    super.key,
    required this.currentState,
    required this.baseTime,
  });

  @override
  Widget build(BuildContext context) {
    final current = OrderStatusExt.fromString(currentState);
    final currentIndex = OrderStatus.values.indexOf(current);

    return Column(
      children: List.generate(OrderStatus.values.length, (index) {
        final status = OrderStatus.values[index];
        final isCompleted = index <= currentIndex;
        final isLast = index == OrderStatus.values.length - 1;
        final stepTime = baseTime.add(Duration(hours: index));

        return StepItem(
          status: status,
          isCompleted: isCompleted,
          isLast: isLast,
          time: stepTime,
        );
      }),
    );
  }
}
