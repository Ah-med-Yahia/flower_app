import 'package:flower_app/features/occasion/domain/entities/get_occasion_products_entity.dart';
import 'package:flower_app/features/product/best_seller/presentation/view_models/best_seller_events.dart';
import 'package:json_annotation/json_annotation.dart';
import 'product_model.dart';

part 'get_occasion_products_response_model.g.dart';

@JsonSerializable()
class GetOccasionProductsResponseModel {
  final String message;

  @JsonKey(name: 'occasion')
  final ProductModel product;

  const GetOccasionProductsResponseModel({
    required this.message,
    required this.product,
  });

  factory GetOccasionProductsResponseModel.fromJson(
    Map<String, dynamic> json,
  ) => _$GetOccasionProductsResponseModelFromJson(json);

  Map<String, dynamic> toJson() =>
      _$GetOccasionProductsResponseModelToJson(this);

  GetOccasionProductsEntity toEntity() {
    return GetOccasionProductsEntity(products: product.toEntity());
  }
}
