import '../../../../../config/base_response/base_response.dart';
import '../models/product_response_model.dart';

abstract interface class ProductDetailsRepoContract {
  Future<BaseResponse<ProductResponseModel>> getProductDetails(
    String productId,
  );
}
