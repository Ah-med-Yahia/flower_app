import 'package:flower_app/features/checkout/domain/entities/credit_order_entity/collected_information_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'collected_information_model.g.dart';

@JsonSerializable()
class CollectedInformationModel {
  @JsonKey(name: 'business_name')
  final dynamic businessName;
  @JsonKey(name: 'individual_name')
  final dynamic individualName;
  @JsonKey(name: 'shipping_details')
  final dynamic shippingDetails;

  const CollectedInformationModel({
    this.businessName,
    this.individualName,
    this.shippingDetails,
  });

  factory CollectedInformationModel.fromJson(Map<String, dynamic> json) {
    return CollectedInformationModel(
      businessName: json['business_name'] as dynamic,
      individualName: json['individual_name'] as dynamic,
      shippingDetails: json['shipping_details'] as dynamic,
    );
  }

  Map<String, dynamic> toJson() => {
    'business_name': businessName,
    'individual_name': individualName,
    'shipping_details': shippingDetails,
  };

  CollectedInformationEntity toEntity() {
    return CollectedInformationEntity(
      businessName: businessName,
      individualName: individualName,
      shippingDetails: shippingDetails,
    );
  }
}
