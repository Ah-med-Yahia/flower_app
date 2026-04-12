import 'dart:io';

import 'package:flower_app/core/shared/data/models/message_response.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../config/base_response/base_response.dart';
import '../../../../../../config/network/safe_api_call.dart';
import '../../domain/entities/user_data_response_entity.dart';
import '../../domain/repositories/edit_profile_repo.dart';
import '../data_sources/remote/edit_profile_remote_data_source.dart';
import '../models/request/edit_user_data_request_model.dart';

@Injectable(as: EditProfileRepo)
class EditProfileRepoImpl implements EditProfileRepo {
  final EditProfileRemoteDataSource _remoteDataSource;

  const EditProfileRepoImpl(this._remoteDataSource);

  @override
  Future<BaseResponse<UserDataResponseEntity>> updateProfile(
    EditUserDataRequestModel requestModel,
  ) async => safeApiCall<UserDataResponseEntity>(() async {
    final response = await _remoteDataSource.editProfile(requestModel);
    return response.toEntity();
  });

  @override
  Future<BaseResponse<MessageResponse>> uploadImage(File imageFile) async =>
      safeApiCall(() async {
        final response = await _remoteDataSource.uploadUserImage(imageFile);
        return response;
      });
}
