import 'package:flower_app/features/occasion/domain/entities/occasion_product_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product_model.g.dart';

@JsonSerializable()
class ProductModel {
  @JsonKey(name: '_id')
  final String id;

  final String name;
  final String slug;
  final String image;

  final String createdAt;
  final String updatedAt;

  final bool isSuperAdmin;

  const ProductModel({
    required this.id,
    required this.name,
    required this.slug,
    required this.image,
    required this.createdAt,
    required this.updatedAt,
    required this.isSuperAdmin,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductModelToJson(this);

  OccasionProductEntity toEntity() {
    return OccasionProductEntity(
      id: id,
      name: name,
      image: image,
      price: 800,
      priceAfterDiscount: 600,
    );
  }
}
