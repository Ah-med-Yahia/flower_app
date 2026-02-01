import 'package:flower_app/features/checkout/domain/entities/credit_order_entity/customer_details_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'customer_details_model.g.dart';

@JsonSerializable()
class CustomerDetailsModel {
  @JsonKey(name: 'address')
  final dynamic address;
  @JsonKey(name: 'business_name')
  final dynamic businessName;
  @JsonKey(name: 'email')
  final String? email;
  @JsonKey(name: 'individual_name')
  final dynamic individualName;
  @JsonKey(name: 'name')
  final dynamic name;
  @JsonKey(name: 'phone')
  final dynamic phone;
  @JsonKey(name: 'tax_exempt')
  final String? taxExempt;
  @JsonKey(name: 'tax_ids')
  final dynamic taxIds;

  const CustomerDetailsModel({
    this.address,
    this.businessName,
    this.email,
    this.individualName,
    this.name,
    this.phone,
    this.taxExempt,
    this.taxIds,
  });

  factory CustomerDetailsModel.fromJson(Map<String, dynamic> json) {
    return CustomerDetailsModel(
      address: json['address'] as dynamic,
      businessName: json['business_name'] as dynamic,
      email: json['email'] as String?,
      individualName: json['individual_name'] as dynamic,
      name: json['name'] as dynamic,
      phone: json['phone'] as dynamic,
      taxExempt: json['tax_exempt'] as String?,
      taxIds: json['tax_ids'] as dynamic,
    );
  }

  Map<String, dynamic> toJson() => {
    'address': address,
    'business_name': businessName,
    'email': email,
    'individual_name': individualName,
    'name': name,
    'phone': phone,
    'tax_exempt': taxExempt,
    'tax_ids': taxIds,
  };

  CustomerDetailsEntity toEntity() {
    return CustomerDetailsEntity(
      address: address,
      businessName: businessName,
      email: email,
      individualName: individualName,
      name: name,
      phone: phone,
      taxExempt: taxExempt,
      taxIds: taxIds,
    );
  }
}
