import 'package:injectable/injectable.dart';

import '../../../../../config/base_response/base_response.dart';
import '../../../../../config/network/safe_api_call.dart';
import '../../domain/entities/forget_password_entity.dart';
import '../../domain/entities/reset_password_entity.dart';
import '../../domain/entities/verify_otp_code_entity.dart';
import '../../domain/repositories/forget_password_repo.dart';
import '../datasources/remote/forget_password_remote_data_source.dart';

@Injectable(as: ForgetPasswordRepo)
class ForgetPasswordRepoImpl implements ForgetPasswordRepo {
  ForgetPasswordRepoImpl(this._remoteDataSource);

  final ForgetPasswordRemoteDataSource _remoteDataSource;

  @override
  Future<BaseResponse<ForgetPasswordEntity>> forgetPassword({
    required String? email,
  }) async => safeApiCall<ForgetPasswordEntity>(() async {
    final response = await _remoteDataSource.forgetPassword(email: email ?? '');
    return response.toEntity();
  });

  @override
  Future<BaseResponse<ResetPasswordEntity>> resetPassword({
    required String? email,
    required String? newPassword,
  }) async => safeApiCall<ResetPasswordEntity>(() async {
    final response = await _remoteDataSource.resetPassword(
      email: email ?? '',
      newPassword: newPassword ?? '',
    );
    return response.toEntity();
  });

  @override
  Future<BaseResponse<VerifyOtpCodeEntity>> verifyOtpCode({
    required String? resetCode,
  }) async => safeApiCall<VerifyOtpCodeEntity>(() async {
    final response = await _remoteDataSource.verifyOtpCode(
      resetCode: resetCode ?? '',
    );
    return response.toEntity();
  });
}
