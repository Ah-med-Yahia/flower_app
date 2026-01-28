import 'package:injectable/injectable.dart';

import '../../../../../config/base_response/base_response.dart';
import '../../../../../config/network/safe_api_call.dart';
import '../../data/datasources/change_password_data_source.dart';
import '../../data/models/change_password_request_model/change_password_request.dart';
import '../../data/models/change_password_response_model/change_password_response.dart';
import '../api_client/change_password_api_client.dart';

@Injectable(as: ChangePasswordDataSource)
class ChangePasswordDataSourceImpl implements ChangePasswordDataSource {
  final ChangePasswordApiClient _apiClient;

  ChangePasswordDataSourceImpl(this._apiClient);

  @override
  Future<BaseResponse<ChangePasswordResponse>> changePassword(
    ChangePasswordRequest request,
  ) => safeApiCall<ChangePasswordResponse>(
    () => _apiClient.changePassword(request),
  );
}
