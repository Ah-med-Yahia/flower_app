import 'package:online_exam_app/config/base_response/base_response.dart';
import 'package:online_exam_app/features/product_details/domain/models/product_response_model.dart';

abstract class ProductDetailsRepoContract {
  Future<BaseResponse<ProductResponseModel>> getProductDetails(
    String productId,
  );
}
