import 'dart:io';

import '../../../../../../config/base_response/message_response.dart';
import '../../models/request/edit_user_data_request_model.dart';
import '../../models/response/user_data_response_model.dart';

abstract interface class EditProfileRemoteDataSource {
  Future<UserDataResponseModel> editProfile(
    EditUserDataRequestModel userDataRequestModel,
  );

  Future<MessageResponse> uploadUserImage(File imageFile);
}
