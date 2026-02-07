import 'package:flower_app/features/checkout/domain/entities/adresses/address_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'shipping_address_model.g.dart';

@JsonSerializable()
class ShippingAddressModel {
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

  const ShippingAddressModel({
    this.street,
    this.phone,
    this.city,
    this.lat,
    this.long,
  });

  factory ShippingAddressModel.fromJson(Map<String, dynamic> json) {
    return ShippingAddressModel(
      street: json['street'] as String?,
      phone: json['phone'] as String?,
      city: json['city'] as String?,
      lat: json['lat'] as String?,
      long: json['long'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
    'street': street,
    'phone': phone,
    'city': city,
    'lat': lat,
    'long': long,
  };

  factory ShippingAddressModel.fromEntity(AddressEntity entity) {
    return ShippingAddressModel(
      street: entity.street,
      phone: entity.phone,
      city: entity.city,
      lat: entity.lat,
      long: entity.long,
    );
  }
}
