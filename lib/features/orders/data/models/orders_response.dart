import 'package:flower_app/features/orders/domain/entities/orders_response_entity.dart';
import 'package:json_annotation/json_annotation.dart';
import 'orders_metadata.dart';
import 'order_model.dart';

part 'orders_response.g.dart';

@JsonSerializable()
class OrdersResponse {
  @JsonKey(name: 'message')
  final String? message;

  @JsonKey(name: 'metadata')
  final OrdersMetadata? metadata;

  @JsonKey(name: 'orders')
  final List<OrderModel>? orders;

  OrdersResponse({this.message, this.metadata, this.orders});

  factory OrdersResponse.fromJson(Map<String, dynamic> json) =>
      _$OrdersResponseFromJson(json);

  Map<String, dynamic> toJson() => _$OrdersResponseToJson(this);

  OrdersResponseEntity toEntity() {
    return OrdersResponseEntity(
      orders: orders?.map((order) => order.toEntity()).toList(),
    );
  }
}
