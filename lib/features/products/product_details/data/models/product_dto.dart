// lib/features/products/data/models/product_dto.dart

import 'package:json_annotation/json_annotation.dart';

part 'product_dto.g.dart';

@JsonSerializable(explicitToJson: true)
class ProductDto {
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
  final double price;

  @JsonKey(name: 'priceAfterDiscount')
  final double priceAfterDiscount;

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
  final double rateAvg;

  @JsonKey(name: 'rateCount')
  final int rateCount;

  @JsonKey(name: 'favoriteId')
  final String? favoriteId;

  @JsonKey(name: 'isInWishlist')
  final bool isInWishlist;

  ProductDto({
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
    this.favoriteId,
    required this.isInWishlist,
  });

  factory ProductDto.fromJson(Map<String, dynamic> json) =>
      _$ProductDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ProductDtoToJson(this);
}
