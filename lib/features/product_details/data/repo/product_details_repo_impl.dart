import 'package:injectable/injectable.dart';
import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/features/product_details/data/data_sources/remote/product_details_data_source_contract.dart';
import 'package:flower_app/features/product_details/data/mappers/product_response_dto_mapper.dart';
import 'package:flower_app/features/product_details/domain/models/product_response_model.dart';
import 'package:flower_app/features/product_details/domain/repo/product_details_repo_contract.dart';

@Injectable(as: ProductDetailsRepoContract)
class ProductDetailsRepoImpl implements ProductDetailsRepoContract {
  final ProductDetailsDataSourceContract _datasource;

  ProductDetailsRepoImpl(this._datasource);
  @override
  Future<BaseResponse<ProductResponseModel>> getProductDetails(
    String productId,
  ) async {
    final response = await _datasource.getProductDetails(productId);

    return response.when(
      success: (dto) {
        final ProductResponseModel model = dto.toDomain();
        return BaseResponse.success(model);
      },
      failure: (errorhandeler) {
        return BaseResponse.failure(errorhandeler);
      },
    );
  }
}
