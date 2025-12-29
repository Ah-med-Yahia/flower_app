import 'package:injectable/injectable.dart';
import 'package:online_exam_app/config/base_response/base_response.dart';
import 'package:online_exam_app/config/network/safe_api_call.dart';
import 'package:online_exam_app/features/product/best_seller/data/datasource/remote/best_seller_remote_data_source.dart';
import 'package:online_exam_app/features/product/best_seller/domain/entities/best_seller_response.dart';

import '../../domain/repos/best_seller_repo.dart';

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
