import 'package:injectable/injectable.dart';

import '../../../../../config/base_response/base_response.dart';
import '../../../../../config/cache_modules/secure_storage_module.dart';
import '../../domain/entities/change_password_request_entity/change_password_request_entity.dart';
import '../../domain/repositories/change_password_repo.dart';
import '../datasources/change_password_data_source.dart';
import '../models/change_password_request_model/change_password_request.dart';

@Injectable(as: ChangePasswordRepo)
class ChangePasswordRepoImpl implements ChangePasswordRepo {
  final ChangePasswordDataSource _dataSource;
  final SecureStorageService _secureStorageService;

  ChangePasswordRepoImpl(this._dataSource, this._secureStorageService);

  @override
  Future<BaseResponse<void>> changePassword(
    ChangePasswordRequestEntity requestEntity,
  ) async {
    final response = await _dataSource.changePassword(
      ChangePasswordRequest.fromEntity(requestEntity),
    );

    return response.map(
      success: (response) async {
        await _secureStorageService.saveAuthTokens(
          accessToken: response.data.token,
        );
        return const BaseResponse<void>.success(null);
      },
      failure: (error) {
        return BaseResponse<void>.failure(error.errorHandler);
      },
    );
  }
}
