import 'package:injectable/injectable.dart';
import '../../../../../config/base_response/base_response.dart';
import '../../../../../config/network/safe_api_call.dart';
import '../../data/datasources/register_data_source.dart';
import '../../data/models/register_request/register_request.dart';
import '../../data/models/register_response/register_response.dart';
import '../api_client/register_api_client.dart';

@Injectable(as: RegisterDataSource)
class RegisterDataSourceImpl implements RegisterDataSource {
  final RegisterApiClient registerApiClient;

  RegisterDataSourceImpl({required this.registerApiClient});

  @override
  Future<BaseResponse<RegisterResponseModel>> register(
    RegisterRequestModel request,
  ) {
    return safeApiCall<RegisterResponseModel>(
      () => registerApiClient.register(request),
    );
  }
}
