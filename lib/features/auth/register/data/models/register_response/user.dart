import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? gender;
  final String? phone;
  final String? photo;
  final String? role;
  final List<dynamic>? wishlist;

  @JsonKey(name: '_id')
  final String? id;

  final List<dynamic>? addresses;

  @JsonKey(fromJson: _fromJsonDate, toJson: _toJsonDate)
  final DateTime? createdAt;

  const User({
    this.firstName,
    this.lastName,
    this.email,
    this.gender,
    this.phone,
    this.photo,
    this.role,
    this.wishlist,
    this.id,
    this.addresses,
    this.createdAt,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);

  static DateTime? _fromJsonDate(String? value) =>
      value == null ? null : DateTime.parse(value);

  static String? _toJsonDate(DateTime? date) => date?.toIso8601String();
}
