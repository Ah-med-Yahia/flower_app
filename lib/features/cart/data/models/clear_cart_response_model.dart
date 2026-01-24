import 'dart:convert';

ClearCartResponseModel clearCartResponseModelFromJson(String str) => ClearCartResponseModel.fromJson(json.decode(str));

String clearCartResponseModelToJson(ClearCartResponseModel data) => json.encode(data.toJson());

class ClearCartResponseModel {
    final String message;

    ClearCartResponseModel({
        required this.message,
    });

    factory ClearCartResponseModel.fromJson(Map<String, dynamic> json) => ClearCartResponseModel(
        message: json['message'],
    );

    Map<String, dynamic> toJson() => {
        'message': message,
    };
}
