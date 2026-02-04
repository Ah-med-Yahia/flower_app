import 'order_product_entity.dart';

class OrderItemEntity {
  final String? id;
  final OrderProductEntity? product;
  final int? price;
  final int? quantity;

  OrderItemEntity({this.id, this.product, this.price, this.quantity});
}
