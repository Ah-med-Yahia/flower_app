import 'package:flower_app/features/auth/forget_password/data/models/reset_password_response/reset_password_response.dart';
import 'package:flower_app/features/auth/forget_password/domain/entities/reset_password_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group(
    'All Test Cases Scenarios for ResetPasswordResponse {ResetPasswordResponse.toEntity()}',
    () {
      test(
        'In case Model with correct values, Should convert it to toEntity method with same values',
        () {
          // Arrange
          const String testMessage = 'success';
          const String testToken = 'Token';
          final ResetPasswordResponse response = ResetPasswordResponse(
            message: testMessage,
            token: testToken,
          );

          // Act
          final result = response.toEntity();

          // Assert
          expect(result, isA<ResetPasswordEntity>());
          const expectedToEntity = ResetPasswordEntity(message: testMessage);
          expect(result.message, equals(expectedToEntity.message));
        },
      );
      test(
        'In case Model with null values, Should convert it to toEntity method with empty string values',
        () {
          // Arrange
          const String? testMessage = null;
          const String? testToken = null;
          final ResetPasswordResponse response = ResetPasswordResponse(
            message: testMessage,
            token: testToken,
          );

          // Act
          final result = response.toEntity();

          // Assert
          expect(result, isA<ResetPasswordEntity>());
          const expectedToEntity = ResetPasswordEntity(message: '');
          expect(result.message, equals(expectedToEntity.message));
        },
      );
    },
  );
}
