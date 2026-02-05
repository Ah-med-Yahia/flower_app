import 'package:injectable/injectable.dart';

import '../../../../../config/base_response/base_response.dart';
import '../../../../../config/base_response/message_response.dart';
import '../../../../../config/error_handler/error_handler.dart';
import '../repositories/edit_profile_repo.dart';

@injectable
class UploadImageUseCase {
  final EditProfileRepo _repo;

  const UploadImageUseCase(this._repo);

  Future<BaseResponse<MessageResponse>> execute(
    String imagePath, {
    String? currentImageUrl,
  }) async {
    final bool isChanged = _checkIfDataChanged(imagePath, currentImageUrl);
    if (!isChanged) {
      return BaseResponse.failure(ErrorHandler.handle('No changes detected'));
    }
    return _repo.uploadImage(imagePath);
  }

  bool _checkIfDataChanged(String imagePath, String? currentImageUrl) {
    return imagePath != currentImageUrl || imagePath.isEmpty;
  }
}
