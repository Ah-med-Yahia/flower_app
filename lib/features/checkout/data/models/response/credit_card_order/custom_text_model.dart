import 'package:flower_app/features/checkout/domain/entities/credit_order_entity/custom_text_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'custom_text_model.g.dart';

@JsonSerializable()
class CustomTextModel {
  @JsonKey(name: 'after_submit')
  final dynamic afterSubmit;
  @JsonKey(name: 'shipping_address')
  final dynamic shippingAddress;
  @JsonKey(name: 'submit')
  final dynamic submit;
  @JsonKey(name: 'terms_of_service_acceptance')
  final dynamic termsOfServiceAcceptance;

  const CustomTextModel({
    this.afterSubmit,
    this.shippingAddress,
    this.submit,
    this.termsOfServiceAcceptance,
  });

  factory CustomTextModel.fromJson(Map<String, dynamic> json) =>
      CustomTextModel(
        afterSubmit: json['after_submit'] as dynamic,
        shippingAddress: json['shipping_address'] as dynamic,
        submit: json['submit'] as dynamic,
        termsOfServiceAcceptance:
            json['terms_of_service_acceptance'] as dynamic,
      );

  Map<String, dynamic> toJson() => {
    'after_submit': afterSubmit,
    'shipping_address': shippingAddress,
    'submit': submit,
    'terms_of_service_acceptance': termsOfServiceAcceptance,
  };

  CustomTextEntity toEntity() {
    return CustomTextEntity(
      afterSubmit: afterSubmit,
      shippingAddress: shippingAddress,
      submit: submit,
      termsOfServiceAcceptance: termsOfServiceAcceptance,
    );
  }
}
