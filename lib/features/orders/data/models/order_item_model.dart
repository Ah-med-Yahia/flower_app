import 'package:flower_app/features/orders/data/models/order_product_model.dart';
import 'package:flower_app/features/orders/domain/entities/order_item_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'order_item_model.g.dart';

@JsonSerializable()
class OrderItemModel {
  @JsonKey(name: '_id')
  final String? id;

  @JsonKey(name: 'product')
  final OrderProductModel? product;

  @JsonKey(name: 'price')
  final int? price;

  @JsonKey(name: 'quantity')
  final int? quantity;

  OrderItemModel({this.id, this.product, this.price, this.quantity});

  factory OrderItemModel.fromJson(Map<String, dynamic> json) =>
      _$OrderItemModelFromJson(json);

  Map<String, dynamic> toJson() => _$OrderItemModelToJson(this);

  OrderItemEntity toEntity() {
    return OrderItemEntity(
      id: id,
      product: product?.toEntity(),
      price: price,
      quantity: quantity,
    );
  }
}
