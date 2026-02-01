import 'package:flower_app/features/checkout/data/models/response/adresses/adress_model.dart';
import 'package:flower_app/features/checkout/domain/entities/adresses/adresses_response_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'adresses_response_model.g.dart';

@JsonSerializable()
class AdressesResponseModel {
  @JsonKey(name: 'message')
  final String? message;
  @JsonKey(name: 'addresses')
  final List<AdressModel>? addresses;

  AdressesResponseModel({this.message, this.addresses});

  factory AdressesResponseModel.fromJson(Map<String, dynamic> json) =>
      _$AdressesResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$AdressesResponseModelToJson(this);

  AdressesResponseEntity toEntity() {
    return AdressesResponseEntity(
      message: message,
      addresses: addresses?.map((e) => e.toEntity()).toList(),
    );
  }
}
