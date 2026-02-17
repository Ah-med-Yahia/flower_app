import 'order_product_entity.dart';

class OrderItemEntity {
  final OrderProductEntity? product;

  final int? quantity;

  OrderItemEntity({this.product, this.quantity});
}
