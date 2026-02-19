import 'package:flower_app/features/products/occasion/domain/entities/get_occasion_products_entity.dart';
import 'package:injectable/injectable.dart';
import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/features/products/occasion/data/datasources/remote_occasion_data_source.dart';
import 'package:flower_app/features/products/occasion/domain/entities/get_all_occasions_list_entity.dart';
import 'package:flower_app/features/products/occasion/domain/repos/occasion_repo_contract.dart';

@Injectable(as: OccasionRepoContract)
class OccasionRepoImpl implements OccasionRepoContract {
  final RemoteOccasionDataSource _occasionDataSourceContract;

  OccasionRepoImpl(this._occasionDataSourceContract);
  @override
  Future<BaseResponse<GetOccasionListEntity>> getAllOccasions() async {
    final response = await _occasionDataSourceContract.getAllOccasions();
    return response.map(
      success: (success) => BaseResponse.success(success.data.toEntity()),
      failure: (failure) => BaseResponse.failure(failure.errorHandler),
    );
  }

  @override
  Future<BaseResponse<GetOccasionProductsEntity>> getOccasionProducts(
    String id,
  ) async {
    final response = await _occasionDataSourceContract.getOccasionProducts(id);
    return response.map(
      success: (success) => BaseResponse.success(success.data.toEntity()),
      failure: (failure) => BaseResponse.failure(failure.errorHandler),
    );
  }
}
