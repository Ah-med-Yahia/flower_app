import 'package:injectable/injectable.dart';
import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/config/network/safe_api_call.dart';
import 'package:flower_app/features/product_details/api/api_clinet/product_details_api_client.dart';
import 'package:flower_app/features/product_details/data/data_sources/remote/product_details_data_source_contract.dart';
import 'package:flower_app/features/product_details/data/models/product_response_dto.dart';

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
