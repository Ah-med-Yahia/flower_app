import 'package:equatable/equatable.dart';
import 'package:flower_app/features/cart/data/models/cart_model/cart_item_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'cart_model.g.dart';

@JsonSerializable()
class CartModel extends Equatable {
  @JsonKey(name: '_id')
  final String? id;
  @JsonKey(name: 'user')
  final String? user;
  @JsonKey(name: 'cartItems')
  final List<CartItemModel> cartItems;
  @JsonKey(name: 'appliedCoupons')
  final List<dynamic>? appliedCoupons;
  @JsonKey(name: 'totalPrice')
  final int totalPrice;
  @JsonKey(name: 'createdAt')
  final DateTime? createdAt;
  @JsonKey(name: 'updatedAt')
  final DateTime? updatedAt;
  @JsonKey(name: '__v')
  final int? v;

  const CartModel({
    this.id,
    this.user,
    required this.cartItems,
    this.appliedCoupons,
    required this.totalPrice,
    this.createdAt,
     this.updatedAt,
     this.v,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) =>
      _$CartModelFromJson(json);

  Map<String, dynamic> toJson() => _$CartModelToJson(this);

  @override
  List<Object?> get props => [
    id,
    user,
    cartItems,
    appliedCoupons,
    totalPrice,
    createdAt,
    updatedAt,
    v,
  ];
}
