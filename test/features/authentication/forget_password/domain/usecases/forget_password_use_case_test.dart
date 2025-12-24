import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:online_exam_app/config/base_response/base_response.dart';
import 'package:online_exam_app/config/error_handler/api_error_model.dart';
import 'package:online_exam_app/config/error_handler/error_handler.dart';
import 'package:online_exam_app/features/authentication/forget_password/domain/entities/forget_password_entity.dart';
import 'package:online_exam_app/features/authentication/forget_password/domain/repositories/forget_password_repo.dart';
import 'package:online_exam_app/features/authentication/forget_password/domain/usecases/forget_password_use_case.dart';
import 'forget_password_use_case_test.mocks.dart';

@GenerateMocks([ForgetPasswordRepo])
void main() {
  late MockForgetPasswordRepo mockRepo;
  late ForgetPasswordUseCase forgetPasswordUseCase;

  setUpAll(() {
    mockRepo = MockForgetPasswordRepo();
    forgetPasswordUseCase = ForgetPasswordUseCase(mockRepo);
  });

  const String testEmail = 'test@example.com';

  group('All Test Cases Scenarios for ForgetPasswordUseCase', () {
    group('In Case Success Response', () {
      // Mock ==> ForgetPasswordEntity
      ForgetPasswordEntity mockForgetPasswordEntity({
        String testMessage = 'success',
        String testInfo = 'OTP sent to your email',
      }) => ForgetPasswordEntity(message: testMessage, info: testInfo);
      test(
        'When email is valid, should return ForgetPasswordEntity with massage and info',
        () async {
          // arrange
          final forgetPasswordEntity = mockForgetPasswordEntity();
          final successResponse = BaseResponse<ForgetPasswordEntity>.success(
            forgetPasswordEntity,
          );

          when(
            mockRepo.forgetPassword(email: testEmail),
          ).thenAnswer((_) async => successResponse);

          // act
          final result = await forgetPasswordUseCase.execute(email: testEmail);

          // assert
          expect(result, isA<BaseResponse<ForgetPasswordEntity>>());
          result.when(
            success: (data) {
              expect(data.message, equals(forgetPasswordEntity.message));
              expect(data.info, equals(forgetPasswordEntity.info));
            },
            failure: (error) => fail('Expected success but got failure'),
          );
          verify(mockRepo.forgetPassword(email: testEmail)).called(1);
        },
      );
    });
    group('In Case Failure Response', () {
      // Failure BaseResponse with ApiErrorModel
      BaseResponse<ForgetPasswordEntity> mockFailureResponse({
        required String testMessage,
      }) {
        final apiErrorModel = ApiErrorModel(message: testMessage);
        final errorHandler = ErrorHandler.handle(apiErrorModel);
        return BaseResponse<ForgetPasswordEntity>.failure(errorHandler);
      }

      test('When email is invalid, should return API error message', () async {
        // arrange
        const String testError =
            'There is no account with this email address  $testEmail';
        final errorResponse = mockFailureResponse(testMessage: testError);

        when(
          mockRepo.forgetPassword(email: testEmail),
        ).thenAnswer((_) async => errorResponse);

        // act
        final result = await forgetPasswordUseCase.execute(email: testEmail);

        // assert
        expect(result, isA<BaseResponse<ForgetPasswordEntity>>());
        result.when(
          success: (data) => fail('Expected failure but got success'),
          failure: (error) {
            expect(error.message, equals(testError));
          },
        );
        verify(mockRepo.forgetPassword(email: testEmail)).called(1);
      });
      test('When email is null should return API error message', () async {
        // arrange
        const String errorMessage =
            'There was an error sending the email. Try again later!';
        final errorResponse = mockFailureResponse(testMessage: errorMessage);

        when(
          mockRepo.forgetPassword(email: null),
        ).thenAnswer((_) async => errorResponse);

        // act
        final result = await forgetPasswordUseCase.execute(email: null);

        // assert
        expect(result, isA<BaseResponse<ForgetPasswordEntity>>());
        result.when(
          success: (data) => fail('Expected failure but got success'),
          failure: (error) {
            expect(error.message, equals(errorMessage));
          },
        );
        verify(mockRepo.forgetPassword(email: null)).called(1);
      });
    });
  });
}
