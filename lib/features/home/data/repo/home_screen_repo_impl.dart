import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/features/home/data/data_sources/remote/home_screen_data_source.dart';
import 'package:flower_app/features/home/data/mappers/home_response_mapper.dart';
import 'package:flower_app/features/home/domain/entities/home_response_entity.dart';
import 'package:flower_app/features/home/domain/repo/home_screen_repo.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: HomeScreenRepo)
class HomeScreenRepoImpl implements HomeScreenRepo {
  final HomeScreenDataSource _homeScreenDataSource;
  HomeScreenRepoImpl(this._homeScreenDataSource);

  @override
  Future<BaseResponse<HomeResponseEntity>> getHomeScreenData() async {
    final response = await _homeScreenDataSource.getHomeScreenData();
    return response.when(
      success: (dto) => BaseResponse.success(dto.toEntity()),
      failure: (errorHandler) => BaseResponse.failure(errorHandler),
    );
  }
}
