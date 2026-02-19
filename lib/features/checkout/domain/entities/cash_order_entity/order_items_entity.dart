import 'package:flower_app/core/shared/domain/entities/products_response_entity/product_entity.dart';

class OrderItemsEntity {
  final ProductEntity? product;
  final int? price;
  final int? quantity;
  final String? id;

  const OrderItemsEntity({this.product, this.price, this.quantity, this.id});
}
