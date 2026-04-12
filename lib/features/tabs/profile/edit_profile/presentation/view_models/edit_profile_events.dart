import 'dart:io';

import '../../data/models/request/edit_user_data_request_model.dart';
import '../../domain/entities/user_data_response_entity.dart';

sealed class EditProfileEvents {}

class ImagePickerEvent extends EditProfileEvents {
  final File imageFile;

  ImagePickerEvent({required this.imageFile});
}

class UpdateUserDataEvent extends EditProfileEvents {
  final EditUserDataRequestModel requestModel;
  final UserDataResponseEntity currentData;

  UpdateUserDataEvent({required this.requestModel, required this.currentData});
}

class NavigateToChangePasswordEvent extends EditProfileEvents {}

enum NavigationAction { changePasswordScreen, profileScreen, none }
