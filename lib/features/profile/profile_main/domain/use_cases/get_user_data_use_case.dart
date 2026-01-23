import 'package:injectable/injectable.dart';

import '../../../../../config/base_response/base_response.dart';
import '../entities/user_data_response.dart';
import '../repos/profile_main_repo.dart';

@injectable
class GetUserDataUseCase {
  final ProfileMainRepo _profileMainRepo;

  GetUserDataUseCase(this._profileMainRepo);

  Future<BaseResponse<UserDataResponse>> call() =>
      _profileMainRepo.getLoggedUserData();
}
