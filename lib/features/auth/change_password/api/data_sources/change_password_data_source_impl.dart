import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/config/network/safe_api_call.dart';
import 'package:flower_app/features/auth/change_password/api/api_client/change_password_api_client.dart';
import 'package:flower_app/features/auth/change_password/data/datasources/change_password_data_source.dart';
import 'package:flower_app/features/auth/change_password/data/models/change_password_request_model/change_password_request.dart';
import 'package:flower_app/features/auth/change_password/data/models/change_password_response_model/change_password_response.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ChangePasswordDataSource)
class ChangePasswordDataSourceImpl implements ChangePasswordDataSource {
  final ChangePasswordApiClient _apiClient;

  ChangePasswordDataSourceImpl(this._apiClient);
  @override
  Future<BaseResponse<ChangePasswordResponse>> changePassword(
    ChangePasswordRequest request,
  ) {
    return safeApiCall<ChangePasswordResponse>(
      () => _apiClient.changePassword(request),
    );
  }
}
