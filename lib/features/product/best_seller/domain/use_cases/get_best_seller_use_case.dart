import 'package:injectable/injectable.dart';

import '../../../../../config/base_response/base_response.dart';
import '../entities/best_seller_response.dart';
import '../repos/best_seller_repo.dart';

@injectable
class GetBestSellerUseCase {
  final BestSellerRepo _bestSellerRepo;

  GetBestSellerUseCase(this._bestSellerRepo);

  Future<BaseResponse<BestSellerResponse>> call() async =>
      await _bestSellerRepo.getBestSeller();
}
