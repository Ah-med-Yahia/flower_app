import 'package:online_exam_app/features/product_details/data/mappers/product_dto_mapper.dart';
import 'package:online_exam_app/features/product_details/data/models/product_response_dto.dart';
import 'package:online_exam_app/features/product_details/domain/models/product_response_model.dart';

extension ProductResponseDtoMapper on ProductResponseDto {
  ProductResponseModel toDomain() {
    return ProductResponseModel(message: message, product: product.toDomain());
  }
}
