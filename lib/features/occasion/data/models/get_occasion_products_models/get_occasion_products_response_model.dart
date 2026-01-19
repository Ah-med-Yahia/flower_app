import 'package:json_annotation/json_annotation.dart';
import 'package:flower_app/features/occasion/domain/entities/get_occasion_products_entity.dart';
import 'product_model.dart';
import 'product_metadata_model.dart';

part 'get_occasion_products_response_model.g.dart';

@JsonSerializable()
class GetOccasionProductsResponseModel {
  final String message;
  final ProductMetadataModel metadata;
  final List<ProductModel> products;

  GetOccasionProductsResponseModel({
    required this.message,
    required this.metadata,
    required this.products,
  });

  factory GetOccasionProductsResponseModel.fromJson(
    Map<String, dynamic> json,
  ) => _$GetOccasionProductsResponseModelFromJson(json);

  Map<String, dynamic> toJson() =>
      _$GetOccasionProductsResponseModelToJson(this);

  GetOccasionProductsEntity toEntity() {
    return GetOccasionProductsEntity(
      products: products.map((e) => e.toEntity()).toList(),
    );
  }
}
