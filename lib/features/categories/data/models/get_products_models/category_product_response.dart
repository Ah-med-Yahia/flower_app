import 'package:json_annotation/json_annotation.dart';

import '../../../domain/entities/get_categories_products_entity.dart';
import 'category_product_model.dart';

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
