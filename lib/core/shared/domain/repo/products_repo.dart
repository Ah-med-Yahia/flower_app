import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/core/shared/domain/entities/products_response_entity/products_response_entity.dart';

abstract interface class ProductsRepo {
  Future<BaseResponse<ProductsResponseEntity>> getProducts({
    String? keyword,
    String? categoryId,
    String? sortOption,
    String? occasionId,
  });
}
