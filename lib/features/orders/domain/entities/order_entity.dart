import 'package:flower_app/features/orders/domain/entities/order_item_entity.dart';

class OrderEntity {
  final String? id;
  final String? userId;
  final List<OrderItemEntity>? orderItems;
  final int? totalPrice;
  final String? paymentType;
  final bool? isPaid;
  final bool? isDelivered;
  final String? state;
  final String? createdAt;
  final String? updatedAt;
  final String? orderNumber;

  OrderEntity({
    this.id,
    this.userId,
    this.orderItems,
    this.totalPrice,
    this.paymentType,
    this.isPaid,
    this.isDelivered,
    this.state,
    this.createdAt,
    this.updatedAt,
    this.orderNumber,
  });
}
