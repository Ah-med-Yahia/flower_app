import 'package:injectable/injectable.dart';

import '../../../../../../config/base_response/base_response.dart';
import '../../../../../../config/network/safe_api_call.dart';
import '../../../data/data_sources/remote/product_details_data_source_contract.dart';
import '../../../data/models/product_response_dto.dart';
import '../../api_clinet/product_details_api_client.dart';

@Injectable(as: ProductDetailsDataSourceContract)
class ProductDetailsDataSourceImpl implements ProductDetailsDataSourceContract {
  ProductDetailsDataSourceImpl(this._apiClient);

  final ProductDetailsApiClient _apiClient;

  @override
  Future<BaseResponse<ProductResponseDto>> getProductDetails(
    String productId,
  ) async {
    return safeApiCall<ProductResponseDto>(() {
      return _apiClient.getProductDetails(productId);
    });
  }
}
