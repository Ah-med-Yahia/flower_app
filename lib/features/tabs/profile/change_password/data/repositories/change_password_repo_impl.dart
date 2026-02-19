import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/config/cache_modules/secure_storage_module.dart';
import 'package:flower_app/features/tabs/profile/change_password/data/datasources/change_password_data_source.dart';
import 'package:flower_app/features/tabs/profile/change_password/data/models/change_password_request_model/change_password_request.dart';
import 'package:flower_app/features/tabs/profile/change_password/domain/entities/change_password_request_entity/change_password_request_entity.dart';
import 'package:flower_app/features/tabs/profile/change_password/domain/repositories/change_password_repo.dart';
import 'package:injectable/injectable.dart';

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
