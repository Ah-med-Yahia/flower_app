import 'dart:io';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../../core/constants/api_constants.dart';
import '../../data/models/request/edit_user_data_request_model.dart';
import '../../data/models/response/upload_image_response_model.dart';
import '../../data/models/response/user_data_response_model.dart';

part 'edit_profile_api_client.g.dart';

@injectable
@RestApi()
abstract class EditProfileApiClient {
  @factoryMethod
  factory EditProfileApiClient(Dio dio) = _EditProfileApiClient;

  @MultiPart()
  @PUT(ApiConstants.uploadUserImageEndPoint)
  Future<UploadImageResponseModel> uploadUserImage(
    @Part(name: ApiConstants.photoPart) File imageFile,
  );

  @PUT(ApiConstants.editProfileEndPoint)
  Future<UserDataResponseModel> editProfile(
    @Body() EditUserDataRequestModel request,
  );
}
