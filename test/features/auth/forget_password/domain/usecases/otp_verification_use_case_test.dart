import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:online_exam_app/config/base_response/base_response.dart';
import 'package:online_exam_app/config/error_handler/api_error_model.dart';
import 'package:online_exam_app/config/error_handler/error_handler.dart';
import 'package:online_exam_app/features/auth/forget_password/domain/entities/verify_otp_code_entity.dart';
import 'package:online_exam_app/features/auth/forget_password/domain/usecases/otp_verification_use_case.dart';

import 'forget_password_use_case_test.mocks.dart';

void main() {
  late MockForgetPasswordRepo mockRepo;
  late OtpVerificationUseCase otpVerificationUseCase;

  setUpAll(() {
    mockRepo = MockForgetPasswordRepo();
    otpVerificationUseCase = OtpVerificationUseCase(mockRepo);
  });

  const String testOTPCode = '123456';

  group('All Test Cases Scenarios for OtpVerificationUseCase', () {
    group('In Case Success Response', () {
      // Mock ==> VerifyOtpCodeEntity
      VerifyOtpCodeEntity mockVerifyOtpCodeEntity({
        String testStatus = 'Success',
      }) => VerifyOtpCodeEntity(status: testStatus);
      test(
        'When resetCode is valid, should return VerifyOtpCodeEntity with status contain Success',
            () async {
          // arrange
          final verifyOtpCodeEntity = mockVerifyOtpCodeEntity();
          final successResponse = BaseResponse<VerifyOtpCodeEntity>.success(
            verifyOtpCodeEntity,
          );

          when(
            mockRepo.verifyOtpCode(resetCode: testOTPCode),
          ).thenAnswer((_) async => successResponse);

          // act
          final result = await otpVerificationUseCase.execute(otpCode: testOTPCode);

          // assert
          expect(result, isA<BaseResponse<VerifyOtpCodeEntity>>());
          result.when(
            success: (data) {
              expect(data.status, equals(verifyOtpCodeEntity.status));
              expect(data.status.contains('Success'), equals(true));
            },
            failure: (error) => fail('Expected success but got failure'),
          );
          verify(mockRepo.verifyOtpCode(resetCode: testOTPCode)).called(1);
        },
      );
    });
    group('In Case Failure Response', () {
      // Failure BaseResponse with ApiErrorModel
      BaseResponse<VerifyOtpCodeEntity> mockFailureResponse({
        required String testMessage,
      }) {
        final apiErrorModel = ApiErrorModel(message: testMessage);
        final errorHandler = ErrorHandler.handle(apiErrorModel);
        return BaseResponse<VerifyOtpCodeEntity>.failure(errorHandler);
      }

      test('When resetCode is invalid, should return API error message', () async {
        // arrange
        const String testError =
            'Reset code is invalid or has expired';
        final errorResponse = mockFailureResponse(testMessage: testError);

        when(
          mockRepo.verifyOtpCode(resetCode: testOTPCode),
        ).thenAnswer((_) async => errorResponse);

        // act
        final result = await otpVerificationUseCase.execute(otpCode: testOTPCode);

        // assert
        expect(result, isA<BaseResponse<VerifyOtpCodeEntity>>());
        result.when(
          success: (data) => fail('Expected failure but got success'),
          failure: (error) {
            expect(error.message, equals(testError));
          },
        );
        verify(mockRepo.verifyOtpCode(resetCode: testOTPCode)).called(1);
      });
      test('When resetCode is null should return API error message', () async {
        // arrange
        const String errorMessage =
            "The \"data\" argument must be of type string or an instance of Buffer, TypedArray, or DataView. Received undefined";
        final errorResponse = mockFailureResponse(testMessage: errorMessage);

        when(
          mockRepo.verifyOtpCode(resetCode: null),
        ).thenAnswer((_) async => errorResponse);

        // act
        final result = await otpVerificationUseCase.execute(otpCode: null);

        // assert
        expect(result, isA<BaseResponse<VerifyOtpCodeEntity>>());
        result.when(
          success: (data) => fail('Expected failure but got success'),
          failure: (error) {
            expect(error.message, equals(errorMessage));
          },
        );
        verify(mockRepo.verifyOtpCode(resetCode: null)).called(1);
      });
    });
  });
}