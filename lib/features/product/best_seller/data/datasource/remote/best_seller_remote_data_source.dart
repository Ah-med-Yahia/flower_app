import '../../models/best_seller_response_dto.dart';

abstract interface class BestSellerRemoteDataSource {
  Future<BestSellerResponseDto> getBestSeller();
}
