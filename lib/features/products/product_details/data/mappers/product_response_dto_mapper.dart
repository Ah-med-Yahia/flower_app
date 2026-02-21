import 'package:flower_app/core/shared/data/mappers/product_mapper.dart';

import '../../domain/models/product_response_model.dart';
import '../models/product_response_dto.dart';

extension ProductResponseDtoMapper on ProductResponseDto {
  ProductResponseModel toDomain() {
    return ProductResponseModel(message: message, product: product.toEntity());
  }
}
