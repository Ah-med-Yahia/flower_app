import 'package:json_annotation/json_annotation.dart';

import '../../../domain/entities/user_data_response_entity.dart';

part 'user_data_response_model.g.dart';

@JsonSerializable()
class UserDataResponseModel {
  @JsonKey(name: 'message')
  String? message;
  @JsonKey(name: 'user')
  UserModel? userModel;

  UserDataResponseModel({this.message, this.userModel});

  factory UserDataResponseModel.fromJson(Map<String, dynamic> json) =>
      _$UserDataResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserDataResponseModelToJson(this);

  UserDataResponseEntity toEntity() => UserDataResponseEntity(
    message: message ?? '',
    userEntity: userModel != null ? userModel!.toEntity() : const UserEntity(),
  );
}

@JsonSerializable()
class UserModel {
  @JsonKey(name: '_id')
  String? id;
  @JsonKey(name: 'firstName')
  String? firstName;
  @JsonKey(name: 'lastName')
  String? lastName;
  @JsonKey(name: 'email')
  String? email;
  @JsonKey(name: 'gender')
  String? gender;
  @JsonKey(name: 'phone')
  String? phone;
  @JsonKey(name: 'photo')
  String? photo;
  @JsonKey(name: 'role')
  String? role;
  @JsonKey(name: 'wishlist')
  List<dynamic>? wishlist;
  @JsonKey(name: 'addresses')
  List<dynamic>? addresses;
  @JsonKey(name: 'createdAt')
  DateTime? createdAt;
  @JsonKey(name: 'password')
  String? password;

  UserModel({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.gender,
    this.phone,
    this.photo,
    this.role,
    this.wishlist,
    this.addresses,
    this.createdAt,
    this.password,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  UserEntity toEntity() => UserEntity(
    firstName: firstName ?? '',
    lastName: lastName ?? '',
    password: password ?? '',
    phoneNumber: phone ?? '',
  );
}
