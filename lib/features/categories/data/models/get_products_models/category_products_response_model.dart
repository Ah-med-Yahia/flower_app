import 'package:flower_app/features/categories/data/models/get_products_models/product_model.dart';
import 'package:flower_app/features/categories/data/models/metadata/category_metadata_model.dart';
import 'package:flower_app/features/categories/domain/entities/category_products_response_entity/category_products_response_entity.dart';
import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'category_products_response_model.g.dart';

CategoryProductsResponseModel categoryProductsResponseModelFromJson(
  String str,
) => CategoryProductsResponseModel.fromJson(json.decode(str));

String categoryProductsResponseModelToJson(
  CategoryProductsResponseModel data,
) => json.encode(data.toJson());

@JsonSerializable()
class CategoryProductsResponseModel {
  @JsonKey(name: 'message')
  final String? message;
  @JsonKey(name: 'metadata')
  final CategoryMetadataModel? metadata;
  @JsonKey(name: 'products')
  final List<ProductModel>? products;

  CategoryProductsResponseModel({this.message, this.metadata, this.products});

  factory CategoryProductsResponseModel.fromJson(Map<String, dynamic> json) =>
      _$CategoryProductsResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryProductsResponseModelToJson(this);

  GetCategoryProductsEntity toEntity() {
    return GetCategoryProductsEntity(
      products: products?.map((e) => e.toEntity()).toList() ?? [],
    );
  }
}
