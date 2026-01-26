import 'package:flower_app/features/auth/forget_password/data/models/forget_password_response/forget_password_response.dart';
import 'package:flower_app/features/auth/forget_password/domain/entities/forget_password_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group(
    'All Test Cases Scenarios for ForgetPasswordResponse {ForgetPasswordResponse.toEntity()}',
    () {
      test(
        'In case Model with correct values, Should convert it to toEntity method with same values',
        () {
          // Arrange
          const String testMessage = 'success';
          const String testInfo = 'OTP sent to your email';
          final ForgetPasswordResponse response = ForgetPasswordResponse(
            message: testMessage,
            info: testInfo,
          );

          // Act
          final result = response.toEntity();

          // Assert
          expect(result, isA<ForgetPasswordEntity>());
          const expectedToEntity = ForgetPasswordEntity(
            message: testMessage,
            info: testInfo,
          );
          expect(result.message, equals(expectedToEntity.message));
          expect(result.info, equals(expectedToEntity.info));
        },
      );
      test(
        'In case Model with null values, Should convert it to toEntity method with empty string values',
        () {
          // Arrange
          const String? testMessage = null;
          const String? testInfo = null;
          final ForgetPasswordResponse response = ForgetPasswordResponse(
            message: testMessage,
            info: testInfo,
          );

          // Act
          final result = response.toEntity();

          // Assert
          expect(result, isA<ForgetPasswordEntity>());
          const expectedToEntity = ForgetPasswordEntity(message: '', info: '');
          expect(result.message, equals(expectedToEntity.message));
          expect(result.info, equals(expectedToEntity.info));
        },
      );
    },
  );
}
