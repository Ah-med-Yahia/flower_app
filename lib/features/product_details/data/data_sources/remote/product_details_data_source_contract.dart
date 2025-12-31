import 'package:online_exam_app/config/base_response/base_response.dart';
import 'package:online_exam_app/features/product_details/data/models/product_response_dto.dart';

abstract class ProductDetailsDataSourceContract {
  Future<BaseResponse<ProductResponseDto>> getProductDetails(String productId);
}
