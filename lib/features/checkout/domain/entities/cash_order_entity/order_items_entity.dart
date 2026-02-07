import 'package:flower_app/features/home/domain/entities/product_entity.dart';

class OrderItemsEntity {
  final ProductEntity? product;
  final int? price;
  final int? quantity;
  final String? id;

  const OrderItemsEntity({this.product, this.price, this.quantity, this.id});
}
