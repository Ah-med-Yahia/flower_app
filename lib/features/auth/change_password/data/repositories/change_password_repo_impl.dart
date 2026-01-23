import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/features/auth/change_password/data/datasources/change_password_data_source.dart';
import 'package:flower_app/features/auth/change_password/data/models/change_password_request_model/change_password_request.dart';
import 'package:flower_app/features/auth/change_password/domain/entities/change_password_request_entity/change_password_request_entity.dart';
import 'package:flower_app/features/auth/change_password/domain/entities/change_password_response_entity/change_password_response_entity.dart';
import 'package:flower_app/features/auth/change_password/domain/repositories/change_password_repo.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ChangePasswordRepo)
class ChangePasswordRepoImpl implements ChangePasswordRepo {
  final ChangePasswordDataSource _dataSource;

  ChangePasswordRepoImpl(this._dataSource);
  @override
  Future<BaseResponse<ChangePasswordResponseEntity>> changePassword(
    ChangePasswordRequestEntity requestEntity,
  ) async {
    final response = await _dataSource.changePassword(
      ChangePasswordRequest.fromEntity(requestEntity),
    );

    return response.map(
      success: (response) {
        final passwordResponse = response.data;
        return BaseResponse<ChangePasswordResponseEntity>.success(
          passwordResponse.toEntity(),
        );
      },
      failure: (error) {
        return BaseResponse<ChangePasswordResponseEntity>.failure(
          error.errorHandler,
        );
      },
    );
  }
}
