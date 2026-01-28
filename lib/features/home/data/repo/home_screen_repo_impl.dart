import 'package:injectable/injectable.dart';

import '../../../../config/base_response/base_response.dart';
import '../../domain/entities/home_response_entity.dart';
import '../../domain/repo/home_screen_repo.dart';
import '../data_sources/remote/home_screen_data_source.dart';
import '../mappers/home_response_mapper.dart';

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
