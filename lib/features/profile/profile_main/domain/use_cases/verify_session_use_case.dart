import 'package:injectable/injectable.dart';

import '../../../../../config/base_response/base_response.dart';
import '../../../../../core/constants/errors_constants.dart';
import '../../../../../core/services/token_service.dart';

sealed class SessionStatus {}

class SessionValid extends SessionStatus {}

class SessionInvalid extends SessionStatus {
  final String reason;

  SessionInvalid(this.reason);
}

@injectable
class VerifySessionUseCase {
  final TokenService _tokenService;

  VerifySessionUseCase(this._tokenService);

  Future<BaseResponse<SessionStatus>> call() async {
    final isLoggedInResponse = await _tokenService.isLoggedIn();

    return await isLoggedInResponse.when(
      success: (isLoggedIn) async {
        if (!isLoggedIn) {
          // Todo(Salah): Handle Localization
          return BaseResponse.success(
            SessionInvalid(ErrorsConstant.userNotLoggedInError),
          );
        }

        final tokenValidResponse = await _tokenService.isTokenValid();
        return tokenValidResponse.when(
          success: (isTokenValid) {
            if (!isTokenValid) {
              // Todo(Salah): Handle Localization
              return BaseResponse.success(
                SessionInvalid(ErrorsConstant.sessionExpiredError),
              );
            }
            return BaseResponse.success(SessionValid());
          },
          failure: (error) => BaseResponse.failure(error),
        );
      },
      failure: (error) => BaseResponse.failure(error),
    );
  }
}
