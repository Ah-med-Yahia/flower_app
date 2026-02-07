import 'package:flower_app/features/checkout/domain/entities/cash_order_entity/cache_order_response_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'order_model.dart';
part 'cache_response_model.g.dart';

@JsonSerializable()
class CacheResponseModel {
  @JsonKey(name: 'message')
  final String? message;
  @JsonKey(name: 'order')
  final OrderModel? order;

  const CacheResponseModel({this.message, this.order});

  factory CacheResponseModel.fromJson(Map<String, dynamic> json) {
    return CacheResponseModel(
      message: json['message'] as String?,
      order: json['order'] == null
          ? null
          : OrderModel.fromJson(json['order'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() => {
    'message': message,
    'order': order?.toJson(),
  };

  CacheOrderResponseEntity toEntity() {
    return CacheOrderResponseEntity(message: message, order: order?.toEntity());
  }
}
