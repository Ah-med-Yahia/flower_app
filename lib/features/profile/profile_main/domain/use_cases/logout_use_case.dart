import 'package:injectable/injectable.dart';

import '../../../../../config/base_response/base_response.dart';
import '../../../../../core/services/token_service.dart';

@injectable
class LogoutUseCase {
  final TokenService _tokenService;

  LogoutUseCase(this._tokenService);

  Future<BaseResponse<void>> call() async {
    // TODO(Mahmoud-Younes): Add logout logic here
    // Future cleanup logic can be added here:
    // - Clear local database
    // - Notify backend of logout
    // - Cancel pending requests
    // - Clear cached data
    return await _tokenService.clearAuthData();
  }
}
