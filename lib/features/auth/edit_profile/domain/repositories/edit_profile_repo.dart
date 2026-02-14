import '../../../../../config/base_response/base_response.dart';
import '../../../../../config/base_response/message_response.dart';
import '../../data/models/request/edit_user_data_request_model.dart';
import '../entities/user_data_response_entity.dart';

abstract interface class EditProfileRepo {
  Future<BaseResponse<UserDataResponseEntity>> updateProfile(
    EditUserDataRequestModel requestModel,
  );

  Future<BaseResponse<MessageResponse>> uploadImage(String imagePath);
}
