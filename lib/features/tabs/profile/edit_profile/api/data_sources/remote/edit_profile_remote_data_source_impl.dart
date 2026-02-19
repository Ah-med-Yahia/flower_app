import 'dart:io';

import 'package:injectable/injectable.dart';

import '../../../../../../../core/shared/data/models/message_response.dart';
import '../../../data/data_sources/remote/edit_profile_remote_data_source.dart';
import '../../../data/models/request/edit_user_data_request_model.dart';
import '../../../data/models/response/user_data_response_model.dart';
import '../../api_client/edit_profile_api_client.dart';

@Injectable(as: EditProfileRemoteDataSource)
class EditProfileRemoteDataSourceImpl implements EditProfileRemoteDataSource {
  final EditProfileApiClient _apiClient;

  EditProfileRemoteDataSourceImpl(this._apiClient);

  @override
  Future<UserDataResponseModel> editProfile(
    EditUserDataRequestModel userDataRequestModel,
  ) async {
    return await _apiClient.editProfile(userDataRequestModel);
  }

  @override
  Future<MessageResponse> uploadUserImage(File imageFile) async {
    return await _apiClient.uploadUserImage(imageFile);
  }
}
