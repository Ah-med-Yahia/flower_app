import 'package:equatable/equatable.dart';
import 'package:flower_app/features/cart/domain/entities/cart_entity/cart_product_entity.dart';

class CartItemEntity extends Equatable {
  final CartProductEntity product;
  final int price;
  final int quantity;

  const CartItemEntity({
    required this.product,
    required this.price,
    required this.quantity,
  });

  @override
  List<Object?> get props => [product, price, quantity,];
}
