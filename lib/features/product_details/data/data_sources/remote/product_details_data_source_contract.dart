import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/features/product_details/data/models/product_response_dto.dart';

abstract interface class ProductDetailsDataSourceContract {
  Future<BaseResponse<ProductResponseDto>> getProductDetails(String productId);
}
