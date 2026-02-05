import 'package:json_annotation/json_annotation.dart';

import '../../../features/auth/edit_profile/domain/entities/user_data_response_entity.dart';

part 'user_model.g.dart';

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
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  UserEntity toEntity() => UserEntity(
    firstName: firstName ?? '',
    lastName: lastName ?? '',
    email: email ?? '',
    phoneNumber: phone ?? '',
    imgAvatarURL: photo ?? '',
  );
}
