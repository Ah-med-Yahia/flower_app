import 'package:equatable/equatable.dart';
import 'package:flower_app/features/cart/domain/entities/cart_entity/cart_item_entity.dart';

class CartEntity extends Equatable {
  final List<CartItemEntity> cartItems;
  final List<dynamic>? appliedCoupons;
  final int totalPrice;
  final int deliveryFee;

  const CartEntity({
    required this.cartItems,
    required this.appliedCoupons,
    required this.totalPrice,
    this.deliveryFee = 10,
  });

  CartEntity copyWith({
    List<CartItemEntity>? cartItems,
    List<dynamic>? appliedCoupons,
    int? totalPrice,
    int? deliveryFee,
  }) {
    return CartEntity(
      cartItems: cartItems ?? this.cartItems,
      appliedCoupons: appliedCoupons ?? this.appliedCoupons,
      totalPrice: totalPrice ?? this.totalPrice,
      deliveryFee: deliveryFee ?? this.deliveryFee,
    );
  }

  @override
  List<Object?> get props => [
    cartItems,
    appliedCoupons,
    totalPrice,
    deliveryFee,
  ];
}
