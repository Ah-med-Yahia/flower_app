import 'package:json_annotation/json_annotation.dart';

import '../../../domain/entities/get_occasion_products_entity.dart';
import 'product_model.dart';

part 'get_occasion_products_response_model.g.dart';

@JsonSerializable()
class GetOccasionProductsResponseModel {
  @JsonKey(name: 'message')
  final String? message;

  @JsonKey(name: 'occasion')
  final ProductModel? product;

  const GetOccasionProductsResponseModel({this.message, this.product});

  factory GetOccasionProductsResponseModel.fromJson(
    Map<String, dynamic> json,
  ) => _$GetOccasionProductsResponseModelFromJson(json);

  Map<String, dynamic> toJson() =>
      _$GetOccasionProductsResponseModelToJson(this);

  GetOccasionProductsEntity toEntity() {
    return GetOccasionProductsEntity(products: product?.toEntity());
  }
}
