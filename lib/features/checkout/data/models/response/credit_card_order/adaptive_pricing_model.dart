import 'package:flower_app/features/checkout/domain/entities/credit_order_entity/adaptive_pricing_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'adaptive_pricing_model.g.dart';

@JsonSerializable()
class AdaptivePricingModel {
  @JsonKey(name: 'enabled')
  final bool? enabled;

  AdaptivePricingModel({this.enabled});

  factory AdaptivePricingModel.fromJson(Map<String, dynamic> json) {
    return _$AdaptivePricingModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$AdaptivePricingModelToJson(this);
  }

  AdaptivePricingEntity toEntity() {
    return AdaptivePricingEntity(enabled: enabled);
  }
}
