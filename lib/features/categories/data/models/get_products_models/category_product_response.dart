import 'package:flower_app/features/categories/data/models/get_products_models/category_product_model.dart';
import 'package:flower_app/features/categories/domain/entities/get_categories_products_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'category_product_response.g.dart';

@JsonSerializable()
class CategoryProductResponse {
  @JsonKey(name: 'message')
  final String? message;

  @JsonKey(name: 'category')
  final CategoryProductModel? product;

  CategoryProductResponse({this.message, this.product});

  factory CategoryProductResponse.fromJson(Map<String, dynamic> json) =>
      _$CategoryProductResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryProductResponseToJson(this);

  GetCategoryProductsEntity toEntity() {
    return GetCategoryProductsEntity(products: product?.toEntity());
  }
}
