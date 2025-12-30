import 'package:online_exam_app/features/product/best_seller/data/models/best_seller_response_dto.dart';

abstract interface class BestSellerRemoteDataSource {
  Future<BestSellerResponseDto> getBestSeller();
}
