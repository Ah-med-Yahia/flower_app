import 'package:flower_app/features/occasion/domain/entities/occasion_product_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product_model.g.dart';

@JsonSerializable()
class ProductModel {
  @JsonKey(name: '_id')
  final String? id;

  @JsonKey(name: 'name')
  final String? name;

  @JsonKey(name: 'slug')
  final String? slug;

  @JsonKey(name: 'image')
  final String? image;

  @JsonKey(name: 'createdAt')
  final String? createdAt;

  @JsonKey(name: 'updatedAt')
  final String? updatedAt;

  @JsonKey(name: 'isSuperAdmin', defaultValue: false)
  final bool isSuperAdmin;

  const ProductModel({
    this.id,
    this.name,
    this.slug,
    this.image,
    this.createdAt,
    this.updatedAt,
    required this.isSuperAdmin,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductModelToJson(this);

  OccasionProductEntity toEntity() {
    return OccasionProductEntity(
      id: id ?? '',
      name: name ?? '',
      image: image ?? '',
      price: 800,
      priceAfterDiscount: 600,
    );
  }
}
