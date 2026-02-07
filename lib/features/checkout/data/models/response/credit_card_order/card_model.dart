import 'package:flower_app/features/checkout/domain/entities/credit_order_entity/card_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'card_model.g.dart';

@JsonSerializable()
class CardModel {
  @JsonKey(name: 'request_three_d_secure')
  final String? requestThreeDSecure;

  const CardModel({this.requestThreeDSecure});

  factory CardModel.fromJson(Map<String, dynamic> json) =>
      CardModel(requestThreeDSecure: json['request_three_d_secure'] as String?);

  Map<String, dynamic> toJson() => {
    'request_three_d_secure': requestThreeDSecure,
  };

  CardEntity toEntity() {
    return CardEntity(requestThreeDSecure: requestThreeDSecure);
  }
}
