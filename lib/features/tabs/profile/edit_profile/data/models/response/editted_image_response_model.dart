import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'editted_image_response_model.g.dart';

EdittedImageResponseModel edittedImageResponseModelFromJson(String str) =>
    EdittedImageResponseModel.fromJson(json.decode(str));

String edittedImageResponseModelToJson(EdittedImageResponseModel data) =>
    json.encode(data.toJson());

@JsonSerializable()
class EdittedImageResponseModel {
  @JsonKey(name: 'message')
  final String message;
  @JsonKey(name: 'user')
  final User user;

  EdittedImageResponseModel({required this.message, required this.user});

  factory EdittedImageResponseModel.fromJson(Map<String, dynamic> json) =>
      _$EdittedImageResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$EdittedImageResponseModelToJson(this);
}

@JsonSerializable()
class User {
  @JsonKey(name: 'photo')
  final String photo;

  User({required this.photo});

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
