import 'package:json_annotation/json_annotation.dart';

part 'saved_addresses_response_model.g.dart';

@JsonSerializable(explicitToJson: true)
class SavedAddressesResponseModel {
  @JsonKey(name: 'message')
  final String? message;

  @JsonKey(name: 'addresses')
  final List<AddressModel>? addresses;

  SavedAddressesResponseModel({required this.message, required this.addresses});

  factory SavedAddressesResponseModel.fromJson(Map<String, dynamic> json) =>
      _$SavedAddressesResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$SavedAddressesResponseModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class AddressModel {
  @JsonKey(name: '_id')
  final String id;

  @JsonKey(name: 'street')
  final String? street;

  @JsonKey(name: 'phone')
  final String? phone;

  @JsonKey(name: 'city')
  final String? city;

  @JsonKey(name: 'lat')
  final String? lat;

  @JsonKey(name: 'long')
  final String? long;

  @JsonKey(name: 'username')
  final String? username;

  AddressModel({
    required this.id,
    required this.street,
    required this.phone,
    required this.city,
    required this.lat,
    required this.long,
    required this.username,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) =>
      _$AddressModelFromJson(json);

  Map<String, dynamic> toJson() => _$AddressModelToJson(this);
}
