import 'package:flower_app/features/categories/domain/entities/categories_product_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'category_product_model.g.dart';

@JsonSerializable()
class CategoryProductModel {
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

  @JsonKey(name: 'isSuperAdmin')
  final bool? isSuperAdmin;

  CategoryProductModel({
    this.id,
    this.name,
    this.slug,
    this.image,
    this.createdAt,
    this.updatedAt,
    this.isSuperAdmin,
  });

  factory CategoryProductModel.fromJson(Map<String, dynamic> json) =>
      _$CategoryProductModelFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryProductModelToJson(this);

  CategoryProductEntity toEntity() {
    return CategoryProductEntity(
      id: id ?? '',
      name: name ?? '',
      image: image ?? '',
      price: 800,
      priceAfterDiscount: 600,
    );
  }
}
