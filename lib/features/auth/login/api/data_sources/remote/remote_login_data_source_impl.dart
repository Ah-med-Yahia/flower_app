import 'package:injectable/injectable.dart';
import '../../../../../../config/base_response/base_response.dart';
import '../../../../../../config/network/safe_api_call.dart';
import '../../../data/datasources/remote/remote_login_data_source.dart';
import '../../../data/models/login_request_model/login_request_model.dart';
import '../../../data/models/login_response_model/login_response_model.dart';
import '../../api_client/login_api_client.dart';

@Injectable(as: RemoteLoginDataSource)
class RemoteLoginDataSourceImpl implements RemoteLoginDataSource {
  final LoginApiClient _loginApiClient;

  RemoteLoginDataSourceImpl(this._loginApiClient);

  @override
  Future<BaseResponse<LoginResponseModel>> login(LoginRequestModel body) {
    return safeApiCall<LoginResponseModel>(() => _loginApiClient.login(body));
  }
}
