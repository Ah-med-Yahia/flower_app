import 'package:injectable/injectable.dart';

import '../../../../../config/base_response/base_response.dart';
import '../../../../../core/services/token_service.dart';

@injectable
class LoadCachedUserDataUseCase {
  final TokenService _tokenService;

  LoadCachedUserDataUseCase(this._tokenService);

  Future<BaseResponse<Map<String, dynamic>?>> call() async {
    return await _tokenService.getUserData();
  }
}
