import 'package:json_annotation/json_annotation.dart';
part 'user_model.g.dart'; 

@JsonSerializable()
class UserModel {
    @JsonKey(name: "_id")
    final String id;
    @JsonKey(name: "firstName")
    final String firstName;
    @JsonKey(name: "lastName")
    final String lastName;
    @JsonKey(name: "email")
    final String email;
    @JsonKey(name: "gender")
    final String gender;
    @JsonKey(name: "phone")
    final String phone;
    @JsonKey(name: "photo")
    final String photo;
    @JsonKey(name: "role")
    final String role;
    @JsonKey(name: "wishlist")
    final List<dynamic> wishlist;
    @JsonKey(name: "addresses")
    final List<dynamic> addresses;
    @JsonKey(name: "createdAt")
    final DateTime createdAt;

    UserModel({
        required this.id,
        required this.firstName,
        required this.lastName,
        required this.email,
        required this.gender,
        required this.phone,
        required this.photo,
        required this.role,
        required this.wishlist,
        required this.addresses,
        required this.createdAt,
    });

    factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);

    Map<String, dynamic> toJson() => _$UserModelToJson(this);
}