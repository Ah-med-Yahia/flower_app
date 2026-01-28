import '../../../../../config/base_response/base_response.dart';
import '../../models/product_response_dto.dart';

abstract interface class ProductDetailsDataSourceContract {
  Future<BaseResponse<ProductResponseDto>> getProductDetails(String productId);
}
