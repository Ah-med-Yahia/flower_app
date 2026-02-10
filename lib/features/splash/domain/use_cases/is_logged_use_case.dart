import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/features/splash/domain/repo/splash_repo.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class IsLoggedUseCase {
  final SplashRepo _splashRepo;

  IsLoggedUseCase(this._splashRepo);
  Future<BaseResponse<bool>> call() async {
    return await _splashRepo.isLogged();
  }
}
