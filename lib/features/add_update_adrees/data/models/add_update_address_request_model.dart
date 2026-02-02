import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'add_update_address_request_model.g.dart';

@JsonSerializable(explicitToJson: true)
class AddUpdateAddressRequestModel extends Equatable {
  @JsonKey(name: 'street')
  final String street;

  @JsonKey(name: 'phone')
  final String phone;

  @JsonKey(name: 'city')
  final String city;

  @JsonKey(name: 'lat')
  final String lat;

  @JsonKey(name: 'long')
  final String long;

  @JsonKey(name: 'username')
  final String username;

  const AddUpdateAddressRequestModel({
    required this.street,
    required this.phone,
    required this.city,
    required this.lat,
    required this.long,
    required this.username,
  });

  factory AddUpdateAddressRequestModel.fromJson(Map<String, dynamic> json) =>
      _$AddUpdateAddressRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$AddUpdateAddressRequestModelToJson(this);

  @override
  List<Object?> get props => [street, phone, city, lat, long, username];
}
