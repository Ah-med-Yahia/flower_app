import 'package:flower_app/features/auth/forget_password/data/models/verify_otp_code_response/verify_otp_code_response.dart';
import 'package:flower_app/features/auth/forget_password/domain/entities/verify_otp_code_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group(
    'All Test Cases Scenarios for VerifyOtpCodeResponse {VerifyOtpCodeResponse.toEntity()}',
    () {
      test(
        'In case Model with correct value, Should convert it to toEntity method with same value',
        () {
          // Arrange
          const String testStatus = 'Success';
          final VerifyOtpCodeResponse response = VerifyOtpCodeResponse(
            status: testStatus,
          );

          // Act
          final result = response.toEntity();

          // Assert
          expect(result, isA<VerifyOtpCodeEntity>());
          final expectedToEntity = VerifyOtpCodeEntity(status: testStatus);
          expect(result.status, equals(expectedToEntity.status));
        },
      );
      test(
        'In case Model with null value, Should convert it to toEntity method with empty string value',
        () {
          // Arrange
          const String? testStatus = null;
          final VerifyOtpCodeResponse response = VerifyOtpCodeResponse(
            status: testStatus,
          );

          // Act
          final result = response.toEntity();

          // Assert
          expect(result, isA<VerifyOtpCodeEntity>());
          final expectedToEntity = VerifyOtpCodeEntity(status: '');
          expect(result.status, equals(expectedToEntity.status));
        },
      );
    },
  );
}
