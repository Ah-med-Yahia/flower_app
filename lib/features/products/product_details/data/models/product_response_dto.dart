// lib/features/products/data/models/product_response_dto.dart

import 'package:flower_app/core/shared/data/models/get_products_models/product_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product_response_dto.g.dart';

@JsonSerializable(explicitToJson: true)
class ProductResponseDto {
  @JsonKey(name: 'message')
  final String message;

  @JsonKey(name: 'product')
  final ProductModel product;

  ProductResponseDto({required this.message, required this.product});

  factory ProductResponseDto.fromJson(Map<String, dynamic> json) =>
      _$ProductResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ProductResponseDtoToJson(this);
}
