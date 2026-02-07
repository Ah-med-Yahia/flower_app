import 'package:flower_app/features/checkout/domain/entities/credit_order_entity/total_details_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'total_details_model.g.dart';

@JsonSerializable()
class TotalDetailsModel {
  @JsonKey(name: 'amount_discount')
  final int? amountDiscount;
  @JsonKey(name: 'amount_shipping')
  final int? amountShipping;
  @JsonKey(name: 'amount_tax')
  final int? amountTax;

  TotalDetailsModel({this.amountDiscount, this.amountShipping, this.amountTax});

  factory TotalDetailsModel.fromJson(Map<String, dynamic> json) =>
      _$TotalDetailsModelFromJson(json);

  Map<String, dynamic> toJson() => _$TotalDetailsModelToJson(this);

  TotalDetailsEntity toEntity() {
    return TotalDetailsEntity(
      amountDiscount: amountDiscount,
      amountShipping: amountShipping,
      amountTax: amountTax,
    );
  }
}
