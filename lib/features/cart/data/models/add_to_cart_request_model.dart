import 'dart:convert';

AddToCartRequestModel addToCartRequestModelFromJson(String str) =>
    AddToCartRequestModel.fromJson(json.decode(str));

String addToCartRequestModelToJson(AddToCartRequestModel data) =>
    json.encode(data.toJson());

class AddToCartRequestModel {
  final String productId;
  final int quantity;

  AddToCartRequestModel({required this.productId, required this.quantity});

  factory AddToCartRequestModel.fromJson(Map<String, dynamic> json) =>
      AddToCartRequestModel(
        productId: json['product'],
        quantity: json['quantity'],
      );

  Map<String, dynamic> toJson() => {'product': productId, 'quantity': quantity};
}