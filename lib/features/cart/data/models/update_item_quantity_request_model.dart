import 'dart:convert';

UpdateItemQuantityRequestModel updateItemQuantityRequestModelFromJson(
  String str,
) => UpdateItemQuantityRequestModel.fromJson(json.decode(str));

String updateItemQuantityRequestModelToJson(
  UpdateItemQuantityRequestModel data,
) => json.encode(data.toJson());

class UpdateItemQuantityRequestModel {
  final int quantity;

  UpdateItemQuantityRequestModel({required this.quantity});

  factory UpdateItemQuantityRequestModel.fromJson(Map<String, dynamic> json) =>
      UpdateItemQuantityRequestModel(quantity: json['quantity']);

  Map<String, dynamic> toJson() => {'quantity': quantity};
}
