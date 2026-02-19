import 'package:flower_app/core/shared/data/models/get_products_models/product_model.dart';
import 'package:flower_app/features/tabs/categories/data/models/metadata/category_metadata_model.dart';
import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'products_response_model.g.dart';

ProductsResponseModel productsResponseModelFromJson(String str) =>
    ProductsResponseModel.fromJson(json.decode(str));

String productsResponseModelToJson(ProductsResponseModel data) =>
    json.encode(data.toJson());

@JsonSerializable()
class ProductsResponseModel {
  @JsonKey(name: 'message')
  final String? message;
  @JsonKey(name: 'metadata')
  final CategoryMetadataModel? metadata;
  @JsonKey(name: 'products')
  final List<ProductModel>? products;

  ProductsResponseModel({this.message, this.metadata, this.products});

  factory ProductsResponseModel.fromJson(Map<String, dynamic> json) =>
      _$ProductsResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductsResponseModelToJson(this);
}
