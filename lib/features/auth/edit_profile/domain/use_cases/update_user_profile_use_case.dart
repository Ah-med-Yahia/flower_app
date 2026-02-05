import 'package:injectable/injectable.dart';

import '../../../../../config/base_response/base_response.dart';
import '../../data/models/request/edit_user_data_request_model.dart';
import '../entities/user_data_response_entity.dart';
import '../repositories/edit_profile_repo.dart';

@injectable
class UpdateUserProfileUseCase {
  final EditProfileRepo _repo;

  const UpdateUserProfileUseCase(this._repo);

  Future<BaseResponse<UserDataResponseEntity>> execute({
    required EditUserDataRequestModel requestModel,
    required UserDataResponseEntity currentData,
  }) async {
    final bool isChanged = _checkIfDataChanged(requestModel, currentData);
    if (!isChanged) return BaseResponse.success(currentData);
    return _repo.updateProfile(requestModel);
  }

  bool _checkIfDataChanged(
    EditUserDataRequestModel request,
    UserDataResponseEntity current,
  ) {
    return request.firstName != current.userEntity.firstName ||
        request.lastName != current.userEntity.lastName ||
        request.phoneNumber != current.userEntity.phoneNumber;
  }
}
