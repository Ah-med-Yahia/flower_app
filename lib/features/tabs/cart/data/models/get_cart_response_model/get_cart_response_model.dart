import 'package:equatable/equatable.dart';
import 'package:flower_app/features/tabs/cart/data/models/cart_model/cart_model.dart';
import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'get_cart_response_model.g.dart';

GetCartResponseModel getCartResponseModelFromJson(String str) =>
    GetCartResponseModel.fromJson(json.decode(str));

String getCartResponseModelToJson(GetCartResponseModel data) =>
    json.encode(data.toJson());

@JsonSerializable()
class GetCartResponseModel extends Equatable {
  @JsonKey(name: 'message')
  final String message;
  @JsonKey(name: 'numOfCartItems')
  final int numOfCartItems;
  @JsonKey(name: 'cart')
  final CartModel cart;

  const GetCartResponseModel({
    required this.message,
    required this.numOfCartItems,
    required this.cart,
  });

  factory GetCartResponseModel.fromJson(Map<String, dynamic> json) =>
      _$GetCartResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$GetCartResponseModelToJson(this);

  @override
  List<Object?> get props => [message, numOfCartItems, cart];
}
