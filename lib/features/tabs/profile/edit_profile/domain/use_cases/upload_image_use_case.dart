import 'dart:io';
import 'package:flower_app/core/shared/data/models/message_response.dart';
import 'package:injectable/injectable.dart';
import '../../../../../../config/base_response/base_response.dart';
import '../../../../../../config/error_handler/error_handler.dart';
import '../repositories/edit_profile_repo.dart';

@injectable
class UploadImageUseCase {
  final EditProfileRepo _repo;

  const UploadImageUseCase(this._repo);

  Future<BaseResponse<MessageResponse>> execute(
    File imageFile, {
    String? currentImageUrl,
  }) async {
    final bool isChanged = _checkIfDataChanged(imageFile, currentImageUrl);
    if (!isChanged) {
      return BaseResponse.failure(ErrorHandler.handle('No changes detected'));
    }
    return _repo.uploadImage(imageFile);
  }

  bool _checkIfDataChanged(File imageFile, String? currentImageUrl) {
    return imageFile.path != currentImageUrl || imageFile.path.isEmpty;
  }
}
