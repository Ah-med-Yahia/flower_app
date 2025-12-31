import 'package:injectable/injectable.dart';

import '../../../data/datasource/remote/best_seller_remote_data_source.dart';
import '../../../data/models/best_seller_response_dto.dart';
import '../../api_client/best_seller_api_client.dart';

@Injectable(as: BestSellerRemoteDataSource)
class BestSellerRemoteDataSourceImpl implements BestSellerRemoteDataSource {
  final BestSellerApiClient _apiClient;

  BestSellerRemoteDataSourceImpl(this._apiClient);

  @override
  Future<BestSellerResponseDto> getBestSeller() async =>
      await _apiClient.getBestSeller();
}
