import 'package:freezed_annotation/freezed_annotation.dart';
import '../product_model.dart';
part 'cart_item_model.g.dart';

@JsonSerializable()
class CartItemModel {
  @JsonKey(name: 'product')
  final ProductModel? product;
  @JsonKey(name: 'price')
  final int? price;
  @JsonKey(name: 'quantity')
  final int? quantity;
  @JsonKey(name: '_id')
  final String? id;

  const CartItemModel({this.product, this.price, this.quantity, this.id});

  factory CartItemModel.fromJson(Map<String, dynamic> json) => CartItemModel(
    product: json['product'] is Map<String, dynamic>
        ? ProductModel.fromJson(json['product'] as Map<String, dynamic>)
        : null,
    price: (json['price'] as num?)?.toInt(),
    quantity: (json['quantity'] as num?)?.toInt(),
    id: json['_id'] as String?,
  );

  Map<String, dynamic> toJson() => {
    'product': product?.toJson(),
    'price': price,
    'quantity': quantity,
    '_id': id,
  };
}
