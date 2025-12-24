import 'package:injectable/injectable.dart';
import '../../../data/datasources/remote/forget_password_remote_data_source.dart';
import '../../../data/models/forget_password_request/forget_password_request.dart';
import '../../../data/models/forget_password_response/forget_password_response.dart';
import '../../../data/models/reset_password_request/reset_password_request.dart';
import '../../../data/models/reset_password_response/reset_password_response.dart';
import '../../../data/models/verify_otp_code_request/verify_otp_code_request.dart';
import '../../../data/models/verify_otp_code_response/verify_otp_code_response.dart';
import '../../api_client/forget_password_api_client.dart';

@Injectable(as: ForgetPasswordRemoteDataSource)
class ForgetPasswordRemoteDataSourceImpl
    implements ForgetPasswordRemoteDataSource {
  ForgetPasswordRemoteDataSourceImpl(this._apiClient);

  final ForgetPasswordApiClient _apiClient;

  @override
  Future<ForgetPasswordResponse> forgetPassword({
    required String email,
  }) async =>
      await _apiClient.forgetPassword(ForgetPasswordRequest(email: email));

  @override
  Future<ResetPasswordResponse> resetPassword({
    required String email,
    required String newPassword,
  }) async => await _apiClient.resetPassword(
    ResetPasswordRequest(email: email, newPassword: newPassword),
  );

  @override
  Future<VerifyOtpCodeResponse> verifyOtpCode({
    required String resetCode,
  }) async => await _apiClient.verifyOtpCode(
    VerifyOtpCodeRequest(resetCode: resetCode),
  );
}
