import 'package:flower_app/features/tabs/profile/edit_profile/domain/entities/edited_image_response_entity.dart';
import '../models/response/editted_image_response_model.dart';

extension EdittedImageMapper on EdittedImageResponseModel {
  EditedImageResponseEntity toEntity() =>
      EditedImageResponseEntity(url: user.photo, message: message);
}
