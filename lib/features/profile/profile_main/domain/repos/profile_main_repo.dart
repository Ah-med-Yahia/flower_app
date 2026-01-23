import 'package:flower_app/features/profile/profile_main/domain/entities/user_data_response.dart';

import '../../../../../config/base_response/base_response.dart';

abstract interface class ProfileMainRepo {
  Future<BaseResponse<UserDataResponse>> getLoggedUserData();
}
