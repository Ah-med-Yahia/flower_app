import 'package:flower_app/features/checkout/domain/entities/credit_order_entity/metadata_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

@JsonSerializable()
class MetadataModel {
  @JsonKey(name: 'city')
  final String? city;
  @JsonKey(name: 'lat')
  final String? lat;
  @JsonKey(name: 'long')
  final String? long;
  @JsonKey(name: 'phone')
  final String? phone;
  @JsonKey(name: 'street')
  final String? street;

  MetadataModel({this.city, this.lat, this.long, this.phone, this.street});

  factory MetadataModel.fromJson(Map<String, dynamic> json) {
    return MetadataModel(
      city: json['city'] as String?,
      lat: json['lat'] as String?,
      long: json['long'] as String?,
      phone: json['phone'] as String?,
      street: json['street'] as String?,
    );
  }
  Map<String, dynamic> toJson() => {
    'city': city,
    'lat': lat,
    'long': long,
    'phone': phone,
    'street': street,
  };

  MetadataEntity toEntity() {
    return MetadataEntity(
      city: city,
      lat: lat,
      long: long,
      phone: phone,
      street: street,
    );
  }
}
