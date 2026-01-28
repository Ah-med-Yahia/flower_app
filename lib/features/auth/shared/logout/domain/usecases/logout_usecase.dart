import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/features/auth/shared/logout/domain/repo/logout_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class LogoutUsecase {
  final LogoutRepo logoutRepo;
  LogoutUsecase(this.logoutRepo);
  Future<BaseResponse<void>> call() async {
    final response = await logoutRepo.clearUserTokens();
    return response;
  }
}
