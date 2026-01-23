import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/features/home/domain/entities/home_response_entity.dart';
import 'package:flower_app/features/home/domain/repo/home_screen_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetHomeDataUsecase {
  final HomeScreenRepo homeRepository;

  GetHomeDataUsecase(this.homeRepository);

  Future<BaseResponse<HomeResponseEntity>> call() async {
    return await homeRepository.getHomeScreenData();
  }
}
