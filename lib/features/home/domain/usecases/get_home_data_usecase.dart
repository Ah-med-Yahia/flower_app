import 'package:injectable/injectable.dart';

import '../../../../config/base_response/base_response.dart';
import '../entities/home_response_entity.dart';
import '../repo/home_screen_repo.dart';

@injectable
class GetHomeDataUsecase {
  final HomeScreenRepo _homeRepository;

  GetHomeDataUsecase(this._homeRepository);

  Future<BaseResponse<HomeResponseEntity>> call() async {
    return await _homeRepository.getHomeScreenData();
  }
}
