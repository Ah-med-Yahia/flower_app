import 'package:flower_app/features/cart/domain/entities/cart_entity/cart_product_entity.dart';

class CartItemEntity {
  final String id;
  final CartProductEntity product;
  final int price;
  final int quantity;

  const CartItemEntity({
    required this.id,
    required this.product,
    required this.price,
    required this.quantity,
  });

  CartItemEntity copyWith({
    String? id,
    CartProductEntity? product,
    int? price,
    int? quantity,
  }) {
    return CartItemEntity(
      id: id ?? this.id,
      product: product ?? this.product,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
    );
  }
}
