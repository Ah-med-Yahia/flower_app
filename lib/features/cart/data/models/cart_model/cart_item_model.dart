import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'cart_item_model.g.dart';

@JsonSerializable()
class CartItemModel extends Equatable {
  @JsonKey(name: 'product')
  final CartProductModel product;
  @JsonKey(name: 'price')
  final int price;
  @JsonKey(name: 'quantity')
  final int quantity;
  @JsonKey(name: '_id')
  final String id;

  const CartItemModel({
    required this.product,
    required this.price,
    required this.quantity,
    required this.id,
  });

  factory CartItemModel.fromJson(Map<String, dynamic> json) =>
      _$CartItemModelFromJson(json);

  Map<String, dynamic> toJson() => _$CartItemModelToJson(this);

  @override
  List<Object?> get props => [id, product, price, quantity];
}

@JsonSerializable()
class CartProductModel {
  @JsonKey(name: '_id')
  final String id;
  @JsonKey(name: 'title')
  final String title;
  @JsonKey(name: 'slug')
  final String slug;
  @JsonKey(name: 'description')
  final String description;
  @JsonKey(name: 'imgCover')
  final String imgCover;
  @JsonKey(name: 'images')
  final List<String> images;
  @JsonKey(name: 'price')
  final int price;
  @JsonKey(name: 'priceAfterDiscount')
  final int priceAfterDiscount;
  @JsonKey(name: 'quantity')
  final int quantity;
  @JsonKey(name: 'category')
  final String category;
  @JsonKey(name: 'occasion')
  final String occasion;
  @JsonKey(name: 'createdAt')
  final DateTime createdAt;
  @JsonKey(name: 'updatedAt')
  final DateTime updatedAt;
  @JsonKey(name: '__v')
  final int v;
  @JsonKey(name: 'isSuperAdmin')
  final bool isSuperAdmin;
  @JsonKey(name: 'sold')
  final int sold;
  @JsonKey(name: 'rateAvg')
  final int rateAvg;
  @JsonKey(name: 'rateCount')
  final int rateCount;
  @JsonKey(name: 'id')
  final String productId;

  CartProductModel({
    required this.id,
    required this.title,
    required this.slug,
    required this.description,
    required this.imgCover,
    required this.images,
    required this.price,
    required this.priceAfterDiscount,
    required this.quantity,
    required this.category,
    required this.occasion,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.isSuperAdmin,
    required this.sold,
    required this.rateAvg,
    required this.rateCount,
    required this.productId,
  });

  factory CartProductModel.fromJson(Map<String, dynamic> json) =>
      _$CartProductModelFromJson(json);

  Map<String, dynamic> toJson() => _$CartProductModelToJson(this);
}
