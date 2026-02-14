import 'package:flower_app/features/checkout/domain/entities/credit_order_entity/automatic_tax_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'automatic_tax_model.g.dart';

@JsonSerializable()
class AutomaticTaxModel {
  @JsonKey(name: 'enabled')
  final bool? enabled;
  @JsonKey(name: 'liability')
  final dynamic liability;
  @JsonKey(name: 'provider')
  final dynamic provider;
  @JsonKey(name: 'status')
  final dynamic status;

  AutomaticTaxModel({this.enabled, this.liability, this.provider, this.status});

  factory AutomaticTaxModel.fromJson(Map<String, dynamic> json) {
    return _$AutomaticTaxModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$AutomaticTaxModelToJson(this);
  }

  AutomaticTaxEntity toEntity() {
    return AutomaticTaxEntity(
      enabled: enabled,
      liability: liability,
      provider: provider,
      status: status,
    );
  }
}
