import 'package:flower_app/features/checkout/domain/entities/credit_order_entity/payment_method_configuration_details_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'payment_method_configuration_details_model.g.dart';

@JsonSerializable()
class PaymentMethodConfigurationDetailsModel {
  @JsonKey(name: 'id')
  final String? id;
  @JsonKey(name: 'parent')
  final dynamic parent;

  const PaymentMethodConfigurationDetailsModel({this.id, this.parent});

  factory PaymentMethodConfigurationDetailsModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return PaymentMethodConfigurationDetailsModel(
      id: json['id'] as String?,
      parent: json['parent'] as dynamic,
    );
  }

  Map<String, dynamic> toJson() => {'id': id, 'parent': parent};

  PaymentMethodConfigurationDetailsEntity toEntity() {
    return PaymentMethodConfigurationDetailsEntity(id: id, parent: parent);
  }
}
