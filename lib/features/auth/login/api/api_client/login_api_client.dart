import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import '../../../../../core/constants/api_constants.dart';
import '../../data/models/login_request_model/login_request_model.dart';
import '../../data/models/login_response_model/login_response_model.dart';

part 'login_api_client.g.dart';

@injectable
@RestApi()
abstract class LoginApiClient {

@factoryMethod
factory LoginApiClient(Dio dio) = _LoginApiClient;
    @POST(ApiConstants.loginEndPoint)
    Future<LoginResponseModel> login(@Body() LoginRequestModel body);
}
