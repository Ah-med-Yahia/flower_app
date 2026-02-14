import 'package:flower_app/features/orders/domain/entities/order_entity.dart';
import 'package:json_annotation/json_annotation.dart';
import 'order_item_model.dart';

part 'order_model.g.dart';

@JsonSerializable()
class OrderModel {
  @JsonKey(name: '_id')
  final String? id;

  @JsonKey(name: 'user')
  final String? user;

  @JsonKey(name: 'orderItems')
  final List<OrderItemModel>? orderItems;

  @JsonKey(name: 'totalPrice')
  final int? totalPrice;

  @JsonKey(name: 'paymentType')
  final String? paymentType;

  @JsonKey(name: 'isPaid')
  final bool? isPaid;

  @JsonKey(name: 'isDelivered')
  final bool? isDelivered;

  @JsonKey(name: 'state')
  final String? state;

  @JsonKey(name: 'createdAt')
  final String? createdAt;

  @JsonKey(name: 'updatedAt')
  final String? updatedAt;

  @JsonKey(name: 'orderNumber')
  final String? orderNumber;

  OrderModel({
    this.id,
    this.user,
    this.orderItems,
    this.totalPrice,
    this.paymentType,
    this.isPaid,
    this.isDelivered,
    this.state,
    this.createdAt,
    this.updatedAt,
    this.orderNumber,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) =>
      _$OrderModelFromJson(json);

  Map<String, dynamic> toJson() => _$OrderModelToJson(this);

  OrderEntity toEntity() {
    return OrderEntity(
      orderItems: orderItems?.map((item) => item.toEntity()).toList(),
      state: state,
      orderNumber: orderNumber,
    );
  }
}
