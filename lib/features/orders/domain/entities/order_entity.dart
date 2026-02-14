import 'package:flower_app/features/orders/domain/entities/order_item_entity.dart';

class OrderEntity {
  final List<OrderItemEntity>? orderItems;
  final String? state;
  final String? orderNumber;

  OrderEntity({this.orderItems, this.state, this.orderNumber});
}
