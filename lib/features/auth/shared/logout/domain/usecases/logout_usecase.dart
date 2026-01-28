import 'package:injectable/injectable.dart';

import '../../../../../../config/base_response/base_response.dart';
import '../repo/logout_repo.dart';

@injectable
class LogoutUsecase {
  final LogoutRepo logoutRepo;

  LogoutUsecase(this.logoutRepo);

  Future<BaseResponse<void>> call() async {
    final response = await logoutRepo.clearUserTokens();
    return response;
  }
}
