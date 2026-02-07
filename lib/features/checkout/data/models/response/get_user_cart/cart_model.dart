import 'package:flower_app/features/checkout/domain/entities/cart/cart_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'cart_item_model.dart';

part 'cart_model.g.dart';

@JsonSerializable()
class CartModel {
  @JsonKey(name: '_id')
  final String? id;
  @JsonKey(name: 'user')
  final String? user;
  @JsonKey(name: 'cartItems')
  final List<CartItemModel>? cartItems;
  @JsonKey(name: 'appliedCoupons')
  final List<dynamic>? appliedCoupons;
  @JsonKey(name: 'totalPrice')
  final num? totalPrice;
  @JsonKey(name: 'createdAt')
  final DateTime? createdAt;
  @JsonKey(name: 'updatedAt')
  final DateTime? updatedAt;
  @JsonKey(name: '__v')
  final int? v;

  const CartModel({
    this.id,
    this.user,
    this.cartItems,
    this.appliedCoupons,
    this.totalPrice,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) => CartModel(
    id: json['_id'] as String?,
    user: json['user'] as String?,
    cartItems: (json['cartItems'] as List<dynamic>?)
        ?.map((e) => CartItemModel.fromJson(e as Map<String, dynamic>))
        .toList(),
    appliedCoupons: json['appliedCoupons'] as List<dynamic>?,
    totalPrice: json['totalPrice'] as num?,
    createdAt: json['createdAt'] == null
        ? null
        : DateTime.parse(json['createdAt'] as String),
    updatedAt: json['updatedAt'] == null
        ? null
        : DateTime.parse(json['updatedAt'] as String),
    v: (json['__v'] as num?)?.toInt(),
  );

  Map<String, dynamic> toJson() => {
    '_id': id,
    'user': user,
    'cartItems': cartItems?.map((e) => e.toJson()).toList(),
    'appliedCoupons': appliedCoupons,
    'totalPrice': totalPrice,
    'createdAt': createdAt?.toIso8601String(),
    'updatedAt': updatedAt?.toIso8601String(),
    '__v': v,
  };

  CartEntity toEntity() {
    return CartEntity(totalPrice: totalPrice?.toInt());
  }
}
