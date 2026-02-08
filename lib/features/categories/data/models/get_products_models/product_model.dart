import 'package:flower_app/features/categories/domain/entities/category_products_response_entity/product_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product_model.g.dart';

@JsonSerializable()
class ProductModel {
  @JsonKey(name: '_id')
  final String id;
  @JsonKey(name: 'title')
  final String title;
  @JsonKey(name: 'slug')
  final String? slug;
  @JsonKey(name: 'description')
  final String? description;
  @JsonKey(name: 'imgCover')
  final String? imgCover;
  @JsonKey(name: 'images')
  final List<String>? images;
  @JsonKey(name: 'price')
  final double price;
  @JsonKey(name: 'priceAfterDiscount')
  final double? priceAfterDiscount;
  @JsonKey(name: 'discount')
  final double? discount;
  @JsonKey(name: 'rateAvg')
  final double? rateAvg;
  @JsonKey(name: 'rateCount')
  final int? rateCount;
  @JsonKey(name: 'quantity')
  final int? quantity;
  @JsonKey(name: 'category')
  final String category;
  @JsonKey(name: 'occasion')
  final String occasion;
  @JsonKey(name: 'isSuperAdmin')
  final bool? isSuperAdmin;
  @JsonKey(name: 'createdAt')
  final DateTime? createdAt;
  @JsonKey(name: 'updatedAt')
  final DateTime? updatedAt;
  @JsonKey(name: '__v')
  final int? v;
  @JsonKey(name: 'sold')
  final int? sold;
  @JsonKey(name: 'favoriteId')
  final dynamic favoriteId;
  @JsonKey(name: 'isInWishlist')
  final bool? isInWishlist;

  ProductModel({
    required this.id,
    required this.title,
    this.slug,
    this.description,
    this.imgCover,
    this.images,
    required this.price,
    this.priceAfterDiscount,
    this.discount,
    this.rateAvg,
    this.rateCount,
    this.quantity,
    required this.category,
    required this.occasion,
    this.isSuperAdmin,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.sold,
    this.favoriteId,
    this.isInWishlist,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductModelToJson(this);

  ProductEntity toEntity() {
    return ProductEntity(
      id: id,
      title: title,
      imageCover: imgCover,
      price: price,
      priceAfterDiscount: priceAfterDiscount,
      categoryId: category,
      occasionId: occasion,
      description: description,
      images: images,
      discount: discount,
      quantity: quantity ?? 0,
    );
  }
}
