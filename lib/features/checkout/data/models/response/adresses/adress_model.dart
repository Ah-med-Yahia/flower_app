import 'package:flower_app/features/checkout/domain/entities/adresses/address_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'adress_model.g.dart';

@JsonSerializable()
class AdressModel {
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
  @JsonKey(name: '_id')
  final String? id;

  const AdressModel({
    this.street,
    this.phone,
    this.city,
    this.lat,
    this.long,
    this.username,
    this.id,
  });

  factory AdressModel.fromJson(Map<String, dynamic> json) =>
      _$AdressModelFromJson(json);

  Map<String, dynamic> toJson() => _$AdressModelToJson(this);

  AddressEntity toEntity() {
    return AddressEntity(street: street, city: city, id: id);
  }
}
