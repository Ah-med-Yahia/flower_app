import 'package:equatable/equatable.dart';
import 'package:flower_app/features/cart/domain/entities/cart_entity/cart_item_entity.dart';

class CartEntity extends Equatable {
  final String id;
  final String user;
  final List<CartItemEntity> cartItems;
  final List<dynamic> appliedCoupons;
  final int totalPrice;
  final DateTime createdAt;
  final DateTime updatedAt;

  const CartEntity({
    required this.id,
    required this.user,
    required this.cartItems,
    required this.appliedCoupons,
    required this.totalPrice,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  List<Object?> get props => [
    id,
    user,
    cartItems,
    appliedCoupons,
    totalPrice,
    createdAt,
    updatedAt,
  ];
}
