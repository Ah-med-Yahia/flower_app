import 'package:injectable/injectable.dart';
import 'package:online_exam_app/config/base_response/base_response.dart';
import 'package:online_exam_app/features/occasion/data/datasources/occasion_data_source_contract.dart';
import 'package:online_exam_app/features/occasion/domain/entities/get_all_occasion_entity.dart';
import 'package:online_exam_app/features/occasion/domain/repos/occasion_repo_contract.dart';

@Injectable(as: OccasionRepoContract)
class OccasionRepoImpl implements OccasionRepoContract {
  final OccasionDataSourceContract occasionDataSourceContract;

  OccasionRepoImpl({required this.occasionDataSourceContract});
  @override
  Future<BaseResponse<GetAllOccasionEntity>> getAllOccasions() async {
    final response = await occasionDataSourceContract.getAllOccasions();
    return response.map(
      success: (success) => BaseResponse.success(success.data.toEntity()),
      failure: (failure) => BaseResponse.failure(failure.errorhandeler),
    );
  }
}
