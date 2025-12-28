import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:online_exam_app/config/base_response/base_response.dart';
import 'package:online_exam_app/config/error_handler/api_error_model.dart';
import 'package:online_exam_app/config/error_handler/error_handler.dart';
import 'package:online_exam_app/features/auth/forget_password/domain/entities/reset_password_entity.dart';
import 'package:online_exam_app/features/auth/forget_password/domain/usecases/reset_password_use_case.dart';

import 'forget_password_use_case_test.mocks.dart';

void main() {
  late MockForgetPasswordRepo mockRepo;
  late ResetPasswordUseCase resetPasswordUseCase;

  setUpAll(() {
    mockRepo = MockForgetPasswordRepo();
    resetPasswordUseCase = ResetPasswordUseCase(mockRepo);
  });

  const String testEmail = 'test@example.com';
  const String testNewPass = 'TestNewPass@123';

  group('All Test Cases Scenarios for ResetPasswordUseCase', () {
    group('In Case Success Response', () {
      // Mock ==> ResetPasswordEntity
      ResetPasswordEntity mockResetPasswordEntity({
        String testMessage = 'success',
        String testToken = 'testToken',
      }) => ResetPasswordEntity(message: testMessage);
      test(
        'When email and new password are valid, should return ResetPasswordEntity with massage and token',
            () async {
          // arrange
          final resetPasswordEntity = mockResetPasswordEntity();
          final successResponse = BaseResponse<ResetPasswordEntity>.success(
            resetPasswordEntity,
          );

          when(
            mockRepo.resetPassword(email: testEmail, newPassword: testNewPass),
          ).thenAnswer((_) async => successResponse);

          // act
          final result = await resetPasswordUseCase.execute(email: testEmail,newPassword: testNewPass);

          // assert
          expect(result, isA<BaseResponse<ResetPasswordEntity>>());
          result.when(
            success: (data) {
              expect(data.message, equals(resetPasswordEntity.message));
            },
            failure: (error) => fail('Expected success but got failure'),
          );
          verify(mockRepo.resetPassword(email: testEmail, newPassword: testNewPass)).called(1);
        },
      );
    });
    group('In Case Failure Response', () {
      // Failure BaseResponse with ApiErrorModel
      BaseResponse<ResetPasswordEntity> mockFailureResponse({
        required String testMessage,
      }) {
        final apiErrorModel = ApiErrorModel(message: testMessage);
        final errorHandler = ErrorHandler.handle(apiErrorModel);
        return BaseResponse<ResetPasswordEntity>.failure(errorHandler);
      }

      test('When email is invalid, should return API error message', () async {
        // arrange
        const String testError =
            'There is no account with this email address  $testEmail';
        final errorResponse = mockFailureResponse(testMessage: testError);

        when(
          mockRepo.resetPassword(email: testEmail, newPassword: testNewPass),
        ).thenAnswer((_) async => errorResponse);

        // act
        final result = await resetPasswordUseCase.execute(email: testEmail, newPassword: testNewPass);

        // assert
        expect(result, isA<BaseResponse<ResetPasswordEntity>>());
        result.when(
          success: (data) => fail('Expected failure but got success'),
          failure: (error) {
            expect(error.message, equals(testError));
          },
        );
        verify(mockRepo.resetPassword(email: testEmail, newPassword: testNewPass)).called(1);
      });
      test('When re-enter same password, should return API error message', () async {
        // arrange
        const String testError =
            'reset code not verified';
        final errorResponse = mockFailureResponse(testMessage: testError);

        when(
          mockRepo.resetPassword(email: testEmail, newPassword: testNewPass),
        ).thenAnswer((_) async => errorResponse);

        // act
        final result = await resetPasswordUseCase.execute(email: testEmail, newPassword: testNewPass);

        // assert
        expect(result, isA<BaseResponse<ResetPasswordEntity>>());
        result.when(
          success: (data) => fail('Expected failure but got success'),
          failure: (error) {
            expect(error.message, equals(testError));
          },
        );
        verify(mockRepo.resetPassword(email: testEmail, newPassword: testNewPass)).called(1);
      });
      test('When both email and new password are null, should return API error message', () async {
        // arrange
        const String testError =
            'reset code not verified';
        final errorResponse = mockFailureResponse(testMessage: testError);

        when(
          mockRepo.resetPassword(email: null, newPassword: null),
        ).thenAnswer((_) async => errorResponse);

        // act
        final result = await resetPasswordUseCase.execute(email: null, newPassword: null);

        // assert
        expect(result, isA<BaseResponse<ResetPasswordEntity>>());
        result.when(
          success: (data) => fail('Expected failure but got success'),
          failure: (error) {
            expect(error.message, equals(testError));
          },
        );
        verify(mockRepo.resetPassword(email: null, newPassword: null)).called(1);
      });
      test('When only email is null, should return API error message', () async {
        // arrange
        const String testError =
            'reset code not verified';
        final errorResponse = mockFailureResponse(testMessage: testError);

        when(
          mockRepo.resetPassword(email: null, newPassword: testNewPass),
        ).thenAnswer((_) async => errorResponse);

        // act
        final result = await resetPasswordUseCase.execute(email: null, newPassword: testNewPass);

        // assert
        expect(result, isA<BaseResponse<ResetPasswordEntity>>());
        result.when(
          success: (data) => fail('Expected failure but got success'),
          failure: (error) {
            expect(error.message, equals(testError));
          },
        );
        verify(mockRepo.resetPassword(email: null, newPassword: testNewPass)).called(1);
      });
      test('When only new password is null, should return API error message', () async {
        // arrange
        const String testError =
            'data and salt arguments required';
        final errorResponse = mockFailureResponse(testMessage: testError);

        when(
          mockRepo.resetPassword(email: testEmail, newPassword: null),
        ).thenAnswer((_) async => errorResponse);

        // act
        final result = await resetPasswordUseCase.execute(email: testEmail, newPassword: null);

        // assert
        expect(result, isA<BaseResponse<ResetPasswordEntity>>());
        result.when(
          success: (data) => fail('Expected failure but got success'),
          failure: (error) {
            expect(error.message, equals(testError));
          },
        );
        verify(mockRepo.resetPassword(email: testEmail, newPassword: null)).called(1);
      });
    });
  });
}