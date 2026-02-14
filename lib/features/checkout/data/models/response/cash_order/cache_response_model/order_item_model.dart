import 'package:flower_app/features/checkout/data/models/response/product_model.dart';
import 'package:flower_app/features/checkout/domain/entities/cash_order_entity/order_items_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'order_item_model.g.dart';

@JsonSerializable()
class OrderItemsModel {
  @JsonKey(name: 'product')
  final ProductModel? product;
  @JsonKey(name: 'price')
  final int? price;
  @JsonKey(name: 'quantity')
  final int? quantity;
  @JsonKey(name: '_id')
  final String? id;

  const OrderItemsModel({this.product, this.price, this.quantity, this.id});

  factory OrderItemsModel.fromJson(Map<String, dynamic> json) =>
      OrderItemsModel(
        product: json['product'] == null
            ? null
            : ProductModel.fromJson(json['product'] as Map<String, dynamic>),
        price: json['price'] as int?,
        quantity: json['quantity'] as int?,
        id: json['_id'] as String?,
      );

  Map<String, dynamic> toJson() => {
    'product': product?.toJson(),
    'price': price,
    'quantity': quantity,
    '_id': id,
  };

  OrderItemsEntity toEntity() {
    return OrderItemsEntity(
      product: product?.toEntity(),
      price: price,
      quantity: quantity,
      id: id,
    );
  }
}
