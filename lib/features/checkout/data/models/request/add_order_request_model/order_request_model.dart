import 'package:flower_app/features/checkout/domain/entities/order_request/order_request_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'shipping_address_model.dart';
part 'order_request_model.g.dart';

@JsonSerializable()
class OrderRequestModel {
  @JsonKey(name: 'shippingAddress')
  final ShippingAddressModel? shippingAddress;

  const OrderRequestModel({this.shippingAddress});

  factory OrderRequestModel.fromJson(Map<String, dynamic> json) =>
      _$OrderRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$OrderRequestModelToJson(this);

  factory OrderRequestModel.fromEntity(OrderRequestEntity entity) {
    return OrderRequestModel(
      shippingAddress: entity.addressEntity == null
          ? null
          : ShippingAddressModel.fromEntity(entity.addressEntity!),
    );
  }
}
