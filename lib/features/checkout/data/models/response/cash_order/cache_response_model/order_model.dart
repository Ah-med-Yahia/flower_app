import 'package:flower_app/features/checkout/domain/entities/cash_order_entity/order_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'order_item_model.dart';
part 'order_model.g.dart';

@JsonSerializable()
class OrderModel {
  @JsonKey(name: 'user')
  final String? user;
  @JsonKey(name: 'orderItems')
  final List<OrderItemsModel>? orderItems;
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
  @JsonKey(name: '_id')
  final String? id;
  @JsonKey(name: 'createdAt')
  final DateTime? createdAt;
  @JsonKey(name: 'updatedAt')
  final DateTime? updatedAt;
  @JsonKey(name: 'orderNumber')
  final String? orderNumber;
  @JsonKey(name: '__v')
  final int? v;

  const OrderModel({
    this.user,
    this.orderItems,
    this.totalPrice,
    this.paymentType,
    this.isPaid,
    this.isDelivered,
    this.state,
    this.id,
    this.createdAt,
    this.updatedAt,
    this.orderNumber,
    this.v,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
    user: json['user'] as String?,
    orderItems: (json['orderItems'] as List<dynamic>?)
        ?.map((e) => OrderItemsModel.fromJson(e as Map<String, dynamic>))
        .toList(),
    totalPrice: json['totalPrice'] as int?,
    paymentType: json['paymentType'] as String?,
    isPaid: json['isPaid'] as bool?,
    isDelivered: json['isDelivered'] as bool?,
    state: json['state'] as String?,
    id: json['_id'] as String?,
    createdAt: json['createdAt'] == null
        ? null
        : DateTime.parse(json['createdAt'] as String),
    updatedAt: json['updatedAt'] == null
        ? null
        : DateTime.parse(json['updatedAt'] as String),
    orderNumber: json['orderNumber'] as String?,
    v: json['__v'] as int?,
  );

  Map<String, dynamic> toJson() => {
    'user': user,
    'orderItems': orderItems?.map((e) => e.toJson()).toList(),
    'totalPrice': totalPrice,
    'paymentType': paymentType,
    'isPaid': isPaid,
    'isDelivered': isDelivered,
    'state': state,
    '_id': id,
    'createdAt': createdAt?.toIso8601String(),
    'updatedAt': updatedAt?.toIso8601String(),
    'orderNumber': orderNumber,
    '__v': v,
  };

  OrderEntity toEntity() {
    return OrderEntity(
      user: user,
      orderItems: orderItems?.map((item) => item.toEntity()).toList(),
      totalPrice: totalPrice,
      paymentType: paymentType,
      isPaid: isPaid,
      isDelivered: isDelivered,
      state: state,
      id: id,
      createdAt: createdAt,
      updatedAt: updatedAt,
      orderNumber: orderNumber,
      V: v,
    );
  }
}
