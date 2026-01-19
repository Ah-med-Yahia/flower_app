import 'package:injectable/injectable.dart';
import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/features/occasion/data/datasources/occasion_data_source_contract.dart';
import 'package:flower_app/features/occasion/domain/entities/get_all_occasion_entity.dart';
import 'package:flower_app/features/occasion/domain/entities/get_occasion_products_entity.dart';
import 'package:flower_app/features/occasion/domain/repos/occasion_repo_contract.dart';

@Injectable(as: OccasionRepoContract)
class OccasionRepoImpl implements OccasionRepoContract {
  final OccasionDataSourceContract _occasionDataSourceContract;

  OccasionRepoImpl(this._occasionDataSourceContract);
  @override
  Future<BaseResponse<GetAllOccasionEntity>> getAllOccasions() async {
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
