import '../../domain/models/product_response_model.dart';
import '../models/product_response_dto.dart';
import 'product_dto_mapper.dart';

extension ProductResponseDtoMapper on ProductResponseDto {
  ProductResponseModel toDomain() {
    return ProductResponseModel(message: message, product: product.toDomain());
  }
}
