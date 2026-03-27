import 'package:flower_app/features/checkout/data/models/request/add_order_request_model/shipping_address_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'order_request_model.g.dart';

@JsonSerializable()
class OrderRequestModel {
  @JsonKey(name: 'shippingAddress')
  final ShippingAddressModel? shippingAddress;

  const OrderRequestModel({this.shippingAddress});

  factory OrderRequestModel.fromJson(Map<String, dynamic> json) =>
      _$OrderRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$OrderRequestModelToJson(this);
}
