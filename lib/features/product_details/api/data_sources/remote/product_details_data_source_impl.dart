import 'package:injectable/injectable.dart';
import 'package:online_exam_app/config/base_response/base_response.dart';
import 'package:online_exam_app/config/error_handler/error_handler.dart';
import 'package:online_exam_app/features/product_details/api/api_clinet/product_details_api_client.dart';
import 'package:online_exam_app/features/product_details/data/data_sources/remote/product_details_data_source_contract.dart';
import 'package:online_exam_app/features/product_details/data/models/product_response_dto.dart';

@Injectable(as: ProductDetailsDataSourceContract)
class ProductDetailsDataSourceImpl implements ProductDetailsDataSourceContract {
  ProductDetailsDataSourceImpl(this._apiClient);

  final ProductDetailsApiClient _apiClient;

  @override
  Future<BaseResponse<ProductResponseDto>> getProductDetails(
    String productId,
  ) async {
    try {
      final ProductResponseDto productResponseDto = await _apiClient
          .getProductDetails(productId);

      return BaseResponse.success(productResponseDto);
    } catch (e) {
      return BaseResponse.failure(ErrorHandler.handle(e));
    }
  }
}
