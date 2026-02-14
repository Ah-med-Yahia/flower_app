import 'package:flower_app/features/checkout/domain/entities/credit_order_entity/credit_card_order_response_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'session_model.dart';
part 'credit_card_order_response_model.g.dart';

@JsonSerializable()
class CreditCardOrderResponseModel {
  @JsonKey(name: 'message')
  final String? message;
  @JsonKey(name: 'session')
  final SessionModel? session;

  const CreditCardOrderResponseModel({this.message, this.session});

  factory CreditCardOrderResponseModel.fromJson(Map<String, dynamic> json) {
    return CreditCardOrderResponseModel(
      message: json['message'] as String?,
      session: json['session'] == null
          ? null
          : SessionModel.fromJson(json['session'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() => {
    'message': message,
    'session': session?.toJson(),
  };

  CreditCardOrderResponseEntity toEntity() {
    return CreditCardOrderResponseEntity(
      message: message,
      session: session?.toEntity(),
    );
  }
}
