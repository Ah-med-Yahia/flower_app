import 'package:flower_app/features/orders/domain/entities/order_entity.dart';
import 'package:flower_app/features/orders/presentation/views/widgets/order_card.dart';
import 'package:flutter/material.dart';

class OrdersList extends StatelessWidget {
  final List<OrderEntity> orders;
  final bool isActive;

  const OrdersList({super.key, required this.orders, required this.isActive});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: orders.length,
      itemBuilder: (context, index) {
        return OrderCard(
          order: orders[index],
          isActive: isActive,
          orderItemEntity: orders[index].orderItems![index],
          product: orders[index].orderItems![index].product!,
        );
      },
    );
  }
}
