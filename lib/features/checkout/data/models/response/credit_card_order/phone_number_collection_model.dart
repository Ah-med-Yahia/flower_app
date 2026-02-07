import 'package:flower_app/features/checkout/domain/entities/credit_order_entity/phone_number_collection_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'phone_number_collection_model.g.dart';

@JsonSerializable()
class PhoneNumberCollectionModel {
  @JsonKey(name: 'enabled')
  final bool? enabled;

  const PhoneNumberCollectionModel({this.enabled});

  factory PhoneNumberCollectionModel.fromJson(Map<String, dynamic> json) {
    return PhoneNumberCollectionModel(enabled: json['enabled'] as bool?);
  }

  Map<String, dynamic> toJson() => {'enabled': enabled};

  PhoneNumberCollectionEntity toEntity() {
    return PhoneNumberCollectionEntity(enabled: enabled);
  }
}
