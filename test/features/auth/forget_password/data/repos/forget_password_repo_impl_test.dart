import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:online_exam_app/config/base_response/base_response.dart';
import 'package:online_exam_app/config/error_handler/error_handler.dart';
import 'package:online_exam_app/features/auth/forget_password/api/datasources/remote/forget_password_remote_data_source_impl.dart';
import 'package:online_exam_app/features/auth/forget_password/data/models/forget_password_response/forget_password_response.dart';
import 'package:online_exam_app/features/auth/forget_password/data/models/reset_password_response/reset_password_response.dart';
import 'package:online_exam_app/features/auth/forget_password/data/models/verify_otp_code_response/verify_otp_code_response.dart';
import 'package:online_exam_app/features/auth/forget_password/data/repos/forget_password_repo_impl.dart';
import 'package:online_exam_app/features/auth/forget_password/domain/entities/forget_password_entity.dart';
import 'package:online_exam_app/features/auth/forget_password/domain/entities/reset_password_entity.dart';
import 'package:online_exam_app/features/auth/forget_password/domain/entities/verify_otp_code_entity.dart';

import 'forget_password_repo_impl_test.mocks.dart';

@GenerateMocks([ForgetPasswordRemoteDataSourceImpl])
void main() {
  late ForgetPasswordRepoImpl repoImpl;
  late MockForgetPasswordRemoteDataSourceImpl mockRemoteDataSource;

  // Test constants
  const tEmail = 'test@example.com';
  const tResetCode = '123456';
  const tNewPassword = 'newPassword123';
  const tMessage = 'Reset code sent successfully';
  const tInfo = 'Check your email';
  const tToken = 'test_token_12345';
  const tStatus = 'Success';

  setUp(() {
    mockRemoteDataSource = MockForgetPasswordRemoteDataSourceImpl();
    repoImpl = ForgetPasswordRepoImpl(mockRemoteDataSource);
  });

  group('All Test Cases Scenarios for ForgetPasswordRepoImpl', () {
    group('In Case Success Response', () {
      group('forgetPassword', () {
        test('should return Success with ForgetPasswordEntity when call succeeds', () async {
          // Arrange
          final mockResponse = ForgetPasswordResponse(
            message: tMessage,
            info: tInfo,
          );

          when(mockRemoteDataSource.forgetPassword(email: tEmail))
              .thenAnswer((_) async => mockResponse);

          // Act
          final result = await repoImpl.forgetPassword(email: tEmail);

          // Assert
          expect(result, isA<Success<ForgetPasswordEntity>>());
          result.when(
            success: (data) {
              expect(data.message, tMessage);
              expect(data.info, tInfo);
            },
            failure: (_) => fail('Should not return failure'),
          );

          verify(mockRemoteDataSource.forgetPassword(email: tEmail)).called(1);
        });

        test('should handle null email by passing empty string', () async {
          // Arrange
          final mockResponse = ForgetPasswordResponse(
            message: tMessage,
            info: tInfo,
          );

          when(mockRemoteDataSource.forgetPassword(email: ''))
              .thenAnswer((_) async => mockResponse);

          // Act
          final result = await repoImpl.forgetPassword(email: null);

          // Assert
          expect(result, isA<Success<ForgetPasswordEntity>>());
          verify(mockRemoteDataSource.forgetPassword(email: '')).called(1);
        });

        test('should convert null response fields to empty strings', () async {
          // Arrange
          final mockResponse = ForgetPasswordResponse(
            message: null,
            info: null,
          );

          when(mockRemoteDataSource.forgetPassword(email: tEmail))
              .thenAnswer((_) async => mockResponse);

          // Act
          final result = await repoImpl.forgetPassword(email: tEmail);

          // Assert
          expect(result, isA<Success<ForgetPasswordEntity>>());
          result.when(
            success: (data) {
              expect(data.message, '');
              expect(data.info, '');
            },
            failure: (_) => fail('Should not return failure'),
          );
        });
      });

      group('verifyOtpCode', () {
        test('should return Success with VerifyOtpCodeEntity when call succeeds', () async {
          // Arrange
          const mockResponse = VerifyOtpCodeResponse(status: tStatus);

          when(mockRemoteDataSource.verifyOtpCode(resetCode: tResetCode))
              .thenAnswer((_) async => mockResponse);

          // Act
          final result = await repoImpl.verifyOtpCode(resetCode: tResetCode);

          // Assert
          expect(result, isA<Success<VerifyOtpCodeEntity>>());
          result.when(
            success: (data) {
              expect(data.status, tStatus);
            },
            failure: (_) => fail('Should not return failure'),
          );

          verify(mockRemoteDataSource.verifyOtpCode(resetCode: tResetCode)).called(1);
        });

        test('should handle null resetCode by passing empty string', () async {
          // Arrange
          const mockResponse = VerifyOtpCodeResponse(status: tStatus);

          when(mockRemoteDataSource.verifyOtpCode(resetCode: ''))
              .thenAnswer((_) async => mockResponse);

          // Act
          final result = await repoImpl.verifyOtpCode(resetCode: null);

          // Assert
          expect(result, isA<Success<VerifyOtpCodeEntity>>());
          verify(mockRemoteDataSource.verifyOtpCode(resetCode: '')).called(1);
        });

        test('should convert null status to empty string', () async {
          // Arrange
          const mockResponse = VerifyOtpCodeResponse(status: null);

          when(mockRemoteDataSource.verifyOtpCode(resetCode: tResetCode))
              .thenAnswer((_) async => mockResponse);

          // Act
          final result = await repoImpl.verifyOtpCode(resetCode: tResetCode);

          // Assert
          expect(result, isA<Success<VerifyOtpCodeEntity>>());
          result.when(
            success: (data) {
              expect(data.status, '');
            },
            failure: (_) => fail('Should not return failure'),
          );
        });
      });

      group('resetPassword', () {
        test('should return Success with ResetPasswordEntity when call succeeds', () async {
          // Arrange
          final mockResponse = ResetPasswordResponse(
            message: tMessage,
            token: tToken,
          );

          when(mockRemoteDataSource.resetPassword(
            email: tEmail,
            newPassword: tNewPassword,
          )).thenAnswer((_) async => mockResponse);

          // Act
          final result = await repoImpl.resetPassword(
            email: tEmail,
            newPassword: tNewPassword,
          );

          // Assert
          expect(result, isA<Success<ResetPasswordEntity>>());
          result.when(
            success: (data) {
              expect(data.message, tMessage);
              expect(data.token, tToken);
            },
            failure: (_) => fail('Should not return failure'),
          );

          verify(mockRemoteDataSource.resetPassword(
            email: tEmail,
            newPassword: tNewPassword,
          )).called(1);
        });

        test('should handle null parameters by passing empty strings', () async {
          // Arrange
          final mockResponse = ResetPasswordResponse(
            message: tMessage,
            token: tToken,
          );

          when(mockRemoteDataSource.resetPassword(email: '', newPassword: ''))
              .thenAnswer((_) async => mockResponse);

          // Act
          final result = await repoImpl.resetPassword(
            email: null,
            newPassword: null,
          );

          // Assert
          expect(result, isA<Success<ResetPasswordEntity>>());
          verify(mockRemoteDataSource.resetPassword(email: '', newPassword: '')).called(1);
        });

        test('should convert null response fields to empty strings', () async {
          // Arrange
          final mockResponse = ResetPasswordResponse(
            message: null,
            token: null,
          );

          when(mockRemoteDataSource.resetPassword(
            email: tEmail,
            newPassword: tNewPassword,
          )).thenAnswer((_) async => mockResponse);

          // Act
          final result = await repoImpl.resetPassword(
            email: tEmail,
            newPassword: tNewPassword,
          );

          // Assert
          expect(result, isA<Success<ResetPasswordEntity>>());
          result.when(
            success: (data) {
              expect(data.message, '');
              expect(data.token, '');
            },
            failure: (_) => fail('Should not return failure'),
          );
        });
      });
    });

    group('In Case Failure Response', () {
      group('forgetPassword', () {
        test('should return Failure when remote call throws DioException', () async {
          // Arrange
          final dioException = DioException(
            requestOptions: RequestOptions(path: ''),
            type: DioExceptionType.badResponse,
            response: Response(
              requestOptions: RequestOptions(path: ''),
              statusCode: 400,
            ),
          );

          when(mockRemoteDataSource.forgetPassword(email: tEmail))
              .thenThrow(dioException);

          // Act
          final result = await repoImpl.forgetPassword(email: tEmail);

          // Assert
          expect(result, isA<Failure<ForgetPasswordEntity>>());
          result.when(
            success: (_) => fail('Should not return success'),
            failure: (error) {
              expect(error, isA<ErrorHandler>());
              expect(error.code, 400);
            },
          );
        });

        test('should return Failure with unauthorized error when status code is 401', () async {
          // Arrange
          final dioException = DioException(
            requestOptions: RequestOptions(path: ''),
            type: DioExceptionType.badResponse,
            response: Response(
              requestOptions: RequestOptions(path: ''),
              statusCode: 401,
            ),
          );

          when(mockRemoteDataSource.forgetPassword(email: tEmail))
              .thenThrow(dioException);

          // Act
          final result = await repoImpl.forgetPassword(email: tEmail);

          // Assert
          expect(result, isA<Failure<ForgetPasswordEntity>>());
          result.when(
            success: (_) => fail('Should not return success'),
            failure: (error) {
              expect(error.code, 401);
            },
          );
        });

        test('should return Failure when connection timeout occurs', () async {
          // Arrange
          final dioException = DioException(
            requestOptions: RequestOptions(path: ''),
            type: DioExceptionType.connectionTimeout,
          );

          when(mockRemoteDataSource.forgetPassword(email: tEmail))
              .thenThrow(dioException);

          // Act
          final result = await repoImpl.forgetPassword(email: tEmail);

          // Assert
          expect(result, isA<Failure<ForgetPasswordEntity>>());
          result.when(
            success: (_) => fail('Should not return success'),
            failure: (error) {
              expect(error, isA<ErrorHandler>());
            },
          );
        });

        test('should return Failure when no internet connection', () async {
          // Arrange
          final dioException = DioException(
            requestOptions: RequestOptions(path: ''),
            type: DioExceptionType.connectionError,
            message: 'socket exception',
          );

          when(mockRemoteDataSource.forgetPassword(email: tEmail))
              .thenThrow(dioException);

          // Act
          final result = await repoImpl.forgetPassword(email: tEmail);

          // Assert
          expect(result, isA<Failure<ForgetPasswordEntity>>());
          result.when(
            success: (_) => fail('Should not return success'),
            failure: (error) {
              expect(error, isA<ErrorHandler>());
            },
          );
        });

        test('should return Failure for unknown errors', () async {
          // Arrange
          when(mockRemoteDataSource.forgetPassword(email: tEmail))
              .thenThrow(Exception('Unknown error'));

          // Act
          final result = await repoImpl.forgetPassword(email: tEmail);

          // Assert
          expect(result, isA<Failure<ForgetPasswordEntity>>());
          result.when(
            success: (_) => fail('Should not return success'),
            failure: (error) {
              expect(error, isA<ErrorHandler>());
            },
          );
        });
      });

      group('verifyOtpCode', () {
        test('should return Failure when remote call throws DioException', () async {
          // Arrange
          final dioException = DioException(
            requestOptions: RequestOptions(path: ''),
            type: DioExceptionType.badResponse,
            response: Response(
              requestOptions: RequestOptions(path: ''),
              statusCode: 400,
            ),
          );

          when(mockRemoteDataSource.verifyOtpCode(resetCode: tResetCode))
              .thenThrow(dioException);

          // Act
          final result = await repoImpl.verifyOtpCode(resetCode: tResetCode);

          // Assert
          expect(result, isA<Failure<VerifyOtpCodeEntity>>());
          result.when(
            success: (_) => fail('Should not return success'),
            failure: (error) {
              expect(error, isA<ErrorHandler>());
              expect(error.code, 400);
            },
          );
        });

        test('should return Failure when invalid OTP code (404)', () async {
          // Arrange
          final dioException = DioException(
            requestOptions: RequestOptions(path: ''),
            type: DioExceptionType.badResponse,
            response: Response(
              requestOptions: RequestOptions(path: ''),
              statusCode: 404,
            ),
          );

          when(mockRemoteDataSource.verifyOtpCode(resetCode: tResetCode))
              .thenThrow(dioException);

          // Act
          final result = await repoImpl.verifyOtpCode(resetCode: tResetCode);

          // Assert
          expect(result, isA<Failure<VerifyOtpCodeEntity>>());
          result.when(
            success: (_) => fail('Should not return success'),
            failure: (error) {
              expect(error.code, 404);
            },
          );
        });

        test('should return Failure when server error occurs (500)', () async {
          // Arrange
          final dioException = DioException(
            requestOptions: RequestOptions(path: ''),
            type: DioExceptionType.badResponse,
            response: Response(
              requestOptions: RequestOptions(path: ''),
              statusCode: 500,
            ),
          );

          when(mockRemoteDataSource.verifyOtpCode(resetCode: tResetCode))
              .thenThrow(dioException);

          // Act
          final result = await repoImpl.verifyOtpCode(resetCode: tResetCode);

          // Assert
          expect(result, isA<Failure<VerifyOtpCodeEntity>>());
          result.when(
            success: (_) => fail('Should not return success'),
            failure: (error) {
              expect(error, isA<ErrorHandler>());
              expect(error.code, 500);
            },
          );
        });

        test('should return Failure when request cancelled', () async {
          // Arrange
          final dioException = DioException(
            requestOptions: RequestOptions(path: ''),
            type: DioExceptionType.cancel,
          );

          when(mockRemoteDataSource.verifyOtpCode(resetCode: tResetCode))
              .thenThrow(dioException);

          // Act
          final result = await repoImpl.verifyOtpCode(resetCode: tResetCode);

          // Assert
          expect(result, isA<Failure<VerifyOtpCodeEntity>>());
          result.when(
            success: (_) => fail('Should not return success'),
            failure: (error) {
              expect(error, isA<ErrorHandler>());
            },
          );
        });

        test('should return Failure for unknown errors', () async {
          // Arrange
          when(mockRemoteDataSource.verifyOtpCode(resetCode: tResetCode))
              .thenThrow(Exception('Unknown error'));

          // Act
          final result = await repoImpl.verifyOtpCode(resetCode: tResetCode);

          // Assert
          expect(result, isA<Failure<VerifyOtpCodeEntity>>());
          result.when(
            success: (_) => fail('Should not return success'),
            failure: (error) {
              expect(error, isA<ErrorHandler>());
            },
          );
        });
      });

      group('resetPassword', () {
        test('should return Failure when remote call throws DioException', () async {
          // Arrange
          final dioException = DioException(
            requestOptions: RequestOptions(path: ''),
            type: DioExceptionType.badResponse,
            response: Response(
              requestOptions: RequestOptions(path: ''),
              statusCode: 400,
            ),
          );

          when(mockRemoteDataSource.resetPassword(
            email: tEmail,
            newPassword: tNewPassword,
          )).thenThrow(dioException);

          // Act
          final result = await repoImpl.resetPassword(
            email: tEmail,
            newPassword: tNewPassword,
          );

          // Assert
          expect(result, isA<Failure<ResetPasswordEntity>>());
          result.when(
            success: (_) => fail('Should not return success'),
            failure: (error) {
              expect(error, isA<ErrorHandler>());
              expect(error.code, 400);
            },
          );
        });

        test('should return Failure when forbidden (403)', () async {
          // Arrange
          final dioException = DioException(
            requestOptions: RequestOptions(path: ''),
            type: DioExceptionType.badResponse,
            response: Response(
              requestOptions: RequestOptions(path: ''),
              statusCode: 403,
            ),
          );

          when(mockRemoteDataSource.resetPassword(
            email: tEmail,
            newPassword: tNewPassword,
          )).thenThrow(dioException);

          // Act
          final result = await repoImpl.resetPassword(
            email: tEmail,
            newPassword: tNewPassword,
          );

          // Assert
          expect(result, isA<Failure<ResetPasswordEntity>>());
          result.when(
            success: (_) => fail('Should not return success'),
            failure: (error) {
              expect(error.code, 403);
            },
          );
        });

        test('should return Failure when receive timeout occurs', () async {
          // Arrange
          final dioException = DioException(
            requestOptions: RequestOptions(path: ''),
            type: DioExceptionType.receiveTimeout,
          );

          when(mockRemoteDataSource.resetPassword(
            email: tEmail,
            newPassword: tNewPassword,
          )).thenThrow(dioException);

          // Act
          final result = await repoImpl.resetPassword(
            email: tEmail,
            newPassword: tNewPassword,
          );

          // Assert
          expect(result, isA<Failure<ResetPasswordEntity>>());
          result.when(
            success: (_) => fail('Should not return success'),
            failure: (error) {
              expect(error, isA<ErrorHandler>());
            },
          );
        });

        test('should return Failure when send timeout occurs', () async {
          // Arrange
          final dioException = DioException(
            requestOptions: RequestOptions(path: ''),
            type: DioExceptionType.sendTimeout,
          );

          when(mockRemoteDataSource.resetPassword(
            email: tEmail,
            newPassword: tNewPassword,
          )).thenThrow(dioException);

          // Act
          final result = await repoImpl.resetPassword(
            email: tEmail,
            newPassword: tNewPassword,
          );

          // Assert
          expect(result, isA<Failure<ResetPasswordEntity>>());
          result.when(
            success: (_) => fail('Should not return success'),
            failure: (error) {
              expect(error, isA<ErrorHandler>());
            },
          );
        });

        test('should return Failure when bad certificate error', () async {
          // Arrange
          final dioException = DioException(
            requestOptions: RequestOptions(path: ''),
            type: DioExceptionType.badCertificate,
          );

          when(mockRemoteDataSource.resetPassword(
            email: tEmail,
            newPassword: tNewPassword,
          )).thenThrow(dioException);

          // Act
          final result = await repoImpl.resetPassword(
            email: tEmail,
            newPassword: tNewPassword,
          );

          // Assert
          expect(result, isA<Failure<ResetPasswordEntity>>());
          result.when(
            success: (_) => fail('Should not return success'),
            failure: (error) {
              expect(error, isA<ErrorHandler>());
            },
          );
        });

        test('should return Failure for unknown errors', () async {
          // Arrange
          when(mockRemoteDataSource.resetPassword(
            email: tEmail,
            newPassword: tNewPassword,
          )).thenThrow(Exception('Unknown error'));

          // Act
          final result = await repoImpl.resetPassword(
            email: tEmail,
            newPassword: tNewPassword,
          );

          // Assert
          expect(result, isA<Failure<ResetPasswordEntity>>());
          result.when(
            success: (_) => fail('Should not return success'),
            failure: (error) {
              expect(error, isA<ErrorHandler>());
            },
          );
        });
      });
    });
  });
}
