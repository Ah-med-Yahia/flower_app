import 'package:json_annotation/json_annotation.dart';
import 'package:flower_app/features/occasion/domain/entities/occasion_product_entity.dart';

part 'product_model.g.dart';

@JsonSerializable()
class ProductModel {
  @JsonKey(name: '_id')
  final String id;

  final String title;
  final String slug;
  final String description;
  final String imgCover;
  final List<String> images;
  final num price;
  final num priceAfterDiscount;
  final int quantity;
  final String category;
  final String occasion;
  final String createdAt;
  final String updatedAt;

  @JsonKey(name: '__v')
  final int v;

  final bool isSuperAdmin;
  final int sold;
  final num rateAvg;
  final int rateCount;
  final String? favoriteId;
  final bool isInWishlist;

  final num? discount;

  ProductModel({
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
    required this.favoriteId,
    required this.isInWishlist,
    this.discount,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductModelToJson(this);
  OccasionProductEntity toEntity() {
    return OccasionProductEntity(
      id: id,
      title: title,
      imgCover: imgCover,
      price: price,
      priceAfterDiscount: priceAfterDiscount,
    );
  }
}
