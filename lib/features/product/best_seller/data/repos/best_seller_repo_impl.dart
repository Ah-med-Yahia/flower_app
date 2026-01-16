import 'package:injectable/injectable.dart';

import '../../../../../config/base_response/base_response.dart';
import '../../../../../config/network/safe_api_call.dart';
import '../../domain/entities/best_seller_response.dart';
import '../../domain/repos/best_seller_repo.dart';
import '../datasource/remote/best_seller_remote_data_source.dart';

@Injectable(as: BestSellerRepo)
class BestSellerRepoImpl implements BestSellerRepo {
  final BestSellerRemoteDataSource _remoteDataSource;

  BestSellerRepoImpl(this._remoteDataSource);

  @override
  Future<BaseResponse<BestSellerResponse>> getBestSeller() async {
    return safeApiCall<BestSellerResponse>(() async {
      final response = await _remoteDataSource.getBestSeller();
      return response.toEntity();
    });
  }
}
