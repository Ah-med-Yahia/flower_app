import 'package:equatable/equatable.dart';
import 'package:flower_app/features/cart/domain/entities/cart_entity/cart_item_entity.dart';

class CartEntity extends Equatable {
  final List<CartItemEntity> cartItems;
  final List<dynamic>? appliedCoupons;
  final int totalPrice;

  const CartEntity({
    required this.cartItems,
    required this.appliedCoupons,
    required this.totalPrice,
  });

  @override
  List<Object?> get props => [
    cartItems,
    appliedCoupons,
    totalPrice,
  ];
}
