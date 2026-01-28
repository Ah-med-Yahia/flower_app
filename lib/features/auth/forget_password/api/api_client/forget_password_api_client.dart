import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../../core/constants/api_constants.dart';
import '../../data/models/forget_password_request/forget_password_request.dart';
import '../../data/models/forget_password_response/forget_password_response.dart';
import '../../data/models/reset_password_request/reset_password_request.dart';
import '../../data/models/reset_password_response/reset_password_response.dart';
import '../../data/models/verify_otp_code_request/verify_otp_code_request.dart';
import '../../data/models/verify_otp_code_response/verify_otp_code_response.dart';

part 'forget_password_api_client.g.dart';

@injectable
@RestApi()
abstract class ForgetPasswordApiClient {
  @factoryMethod
  factory ForgetPasswordApiClient(Dio dio) = _ForgetPasswordApiClient;

  @POST(ApiConstants.forgetPasswordEndpoint)
  Future<ForgetPasswordResponse> forgetPassword(
    @Body() ForgetPasswordRequest request,
  );

  @POST(ApiConstants.verifyResetCodeEndpoint)
  Future<VerifyOtpCodeResponse> verifyOtpCode(
    @Body() VerifyOtpCodeRequest request,
  );

  @PUT(ApiConstants.resetPasswordEndpoint)
  Future<ResetPasswordResponse> resetPassword(
    @Body() ResetPasswordRequest request,
  );
}
