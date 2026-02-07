import 'package:flower_app/features/checkout/domain/entities/credit_order_entity/payment_method_options_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'card_model.dart';
part 'payment_method_options_model.g.dart';

@JsonSerializable()
class PaymentMethodOptionsModel {
  @JsonKey(name: 'card')
  final CardModel? card;

  const PaymentMethodOptionsModel({this.card});

  factory PaymentMethodOptionsModel.fromJson(Map<String, dynamic> json) {
    return PaymentMethodOptionsModel(
      card: json['card'] == null
          ? null
          : CardModel.fromJson(json['card'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() => {'card': card?.toJson()};

  PaymentMethodOptionsEntity toEntity() {
    return PaymentMethodOptionsEntity(card: card?.toEntity());
  }
}
