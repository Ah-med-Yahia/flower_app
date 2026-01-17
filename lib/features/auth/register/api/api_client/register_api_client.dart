import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import '../../../../../core/constants/api_constants.dart';
import '../../data/models/register_request/register_request.dart';
import '../../data/models/register_response/register_response.dart';
part 'register_api_client.g.dart';

@injectable
@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class RegisterApiClient {
  @factoryMethod
  factory RegisterApiClient(Dio dio) = _RegisterApiClient;
  @POST(ApiConstants.registerEndpoint)
  Future<RegisterResponseModel> register(@Body() RegisterRequestModel body);
}
