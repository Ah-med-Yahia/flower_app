import 'dart:io';

import '../../models/request/edit_user_data_request_model.dart';
import '../../models/response/upload_image_response_model.dart';
import '../../models/response/user_data_response_model.dart';

abstract interface class EditProfileRemoteDataSource {
  Future<UserDataResponseModel> editProfile(
    EditUserDataRequestModel userDataRequestModel,
  );

  Future<UploadImageResponseModel> uploadUserImage(File imageFile);
}
