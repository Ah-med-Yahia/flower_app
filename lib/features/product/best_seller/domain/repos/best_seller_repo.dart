import '../../../../../config/base_response/base_response.dart';
import '../entities/best_seller_response.dart';

abstract interface class BestSellerRepo {
  Future<BaseResponse<BestSellerResponse>> getBestSeller();
}
