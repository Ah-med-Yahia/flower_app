import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:online_exam_app/config/base_response/base_response.dart';
import 'package:online_exam_app/config/error_handler/api_error_model.dart';
import 'package:online_exam_app/config/error_handler/error_handler.dart';
import 'package:online_exam_app/features/auth/forget_password/domain/entities/forget_password_entity.dart';
import 'package:online_exam_app/features/auth/forget_password/domain/usecases/forget_password_use_case.dart';
import 'package:online_exam_app/features/auth/forget_password/presentation/view_models/forget_password/forget_password_cubit.dart';
import 'package:online_exam_app/features/auth/forget_password/presentation/view_models/forget_password/forget_password_events.dart';
import 'package:online_exam_app/features/auth/forget_password/presentation/view_models/forget_password/forget_password_state.dart';

import 'forget_password_cubit_test.mocks.dart';

@GenerateMocks([ForgetPasswordUseCase])
void main() {
  late ForgetPasswordCubit cubit;
  late MockForgetPasswordUseCase mockForgetPasswordUseCase;

  setUp(() {
    mockForgetPasswordUseCase = MockForgetPasswordUseCase();
    cubit = ForgetPasswordCubit(mockForgetPasswordUseCase);
  });

  tearDown(() => cubit.close());

  const String testEmail = 'test@example.com';

  group('All Test Cases Scenarios for ForgetPasswordCubit'
      ' when call doIntent() function', () {
    // Test initial state
    group('In Case Initial State', () {
      test('Should start with default values of BaseSate class', () {
        expect(cubit.state, isA<ForgetPasswordState>());
        final forgetPasswordState = cubit.state.forgetPasswordState;
        expect(forgetPasswordState.isLoading, false);
        expect(forgetPasswordState.errorMessage, null);
        expect(forgetPasswordState.data, null);
      });
    });

    group('When call ForgetPasswordEvent intent', () {
      group('In Case Success Response', () {
        final mockEntity = const ForgetPasswordEntity(
          message: 'success',
          info: 'OTP sent to your email',
        );
        final successResponse = BaseResponse<ForgetPasswordEntity>.success(
          mockEntity,
        );
        void successResponseSetUp() async {
          when(
            mockForgetPasswordUseCase.execute(email: testEmail),
          ).thenAnswer((_) async => successResponse);
        }

        const state = ForgetPasswordState();

        blocTest<ForgetPasswordCubit, ForgetPasswordState>(
          'When call _handleForgetPasswordEvent should'
          ' emits [loading = true] state,'
          ' then call _apiCall emits [loading = false, data = dataEntity] states',
          // ARRANGE
          build: () => cubit,
          setUp: () => successResponseSetUp(),
          // ACT
          act: (cubit) =>
              cubit.doIntent(const ForgetPasswordEvent(email: testEmail)),
          // ASSERT
          expect: () => [
            // Loading state
            state.copyWith(
              forgetPasswordState: state.forgetPasswordState.copyWith(
                isLoading: true,
              ),
            ),
            // Success state with data
            state.copyWith(
              forgetPasswordState: state.forgetPasswordState.copyWith(
                isLoading: false,
                data: mockEntity,
              ),
            ),
          ],
          verify: (cubit) {
            verify(
              mockForgetPasswordUseCase.execute(email: testEmail),
            ).called(1);
          },
        );

        test('Verify stores correct data in state', () async {
          // arrange
          successResponseSetUp();

          // act
          await cubit.doIntent(const ForgetPasswordEvent(email: testEmail));

          // assert
          final forgetPasswordState = cubit.state.forgetPasswordState;
          expect(forgetPasswordState.data, equals(mockEntity));
          expect(forgetPasswordState.data?.message, equals(mockEntity.message));
          expect(forgetPasswordState.data?.info, equals(mockEntity.info));
          expect(forgetPasswordState.isLoading, false);
          expect(forgetPasswordState.errorMessage, null);
        });
      });

      group('In Case Failure Response', () {
        const String errorMessage = 'Invalid email address';
        final apiErrorModel = ApiErrorModel(message: errorMessage);
        final errorHandler = ErrorHandler.handle(apiErrorModel);
        final failureResponse = BaseResponse<ForgetPasswordEntity>.failure(
          errorHandler,
        );
        void failureResponseSetUp() async {
          when(
            mockForgetPasswordUseCase.execute(email: testEmail),
          ).thenAnswer((_) async => failureResponse);
        }

        const state = ForgetPasswordState();

        blocTest<ForgetPasswordCubit, ForgetPasswordState>(
          'When call _handleForgetPasswordEvent should'
          ' emits [loading = true] state,'
          ' then call _apiCall emits [loading = false, errorMessage = error message] states',
          build: () => cubit,
          setUp: () => failureResponseSetUp(),
          act: (cubit) =>
              cubit.doIntent(const ForgetPasswordEvent(email: testEmail)),
          expect: () => [
            // Loading state
            state.copyWith(
              forgetPasswordState: state.forgetPasswordState.copyWith(
                isLoading: true,
              ),
            ),
            // Error state
            state.copyWith(
              forgetPasswordState: state.forgetPasswordState.copyWith(
                isLoading: false,
                errorMessage: errorMessage,
              ),
            ),
          ],
          verify: (_) {
            verify(
              mockForgetPasswordUseCase.execute(email: testEmail),
            ).called(1);
          },
        );

        test('Verify stores error message in state', () async {
          // arrange
          failureResponseSetUp();

          // act
          await cubit.doIntent(const ForgetPasswordEvent(email: testEmail));

          // assert
          final forgetPasswordState = cubit.state.forgetPasswordState;
          expect(forgetPasswordState.errorMessage, equals(errorMessage));
          expect(forgetPasswordState.isLoading, false);
          expect(forgetPasswordState.data, null);
        });
      });
    });

    group('When call NavigateToVerifyOtpCode intent', () {
      test('verify events stream is broadcast', () {
        final eventStream = cubit.eventsStream;
        expect(eventStream, isA<Stream<ForgetPasswordEvents>>());
        expect(eventStream.isBroadcast, true);
      });

      test('Verify events stream does not change state when called', () async {
        // arrange
        final initialState = cubit.state;

        // act
        await cubit.doIntent(const NavigateToVerifyOtpCode(email: testEmail));

        // assert
        expect(cubit.state, equals(initialState));
      });

      group('In Case Success Response', () {
        final mockEntity = const ForgetPasswordEntity(
          message: 'success',
          info: 'OTP sent to your email',
        );
        final successResponse = BaseResponse<ForgetPasswordEntity>.success(
          mockEntity,
        );
        void successResponseSetUp() async {
          when(
            mockForgetPasswordUseCase.execute(email: testEmail),
          ).thenAnswer((_) async => successResponse);
        }

        test(
          'When call _navigation should '
          'add broadcast stream event after successful forget password',
          () async {
            // ARRANGE
            successResponseSetUp();
            final events = <ForgetPasswordEvents>[];
            final subscription = cubit.eventsStream.listen(events.add);

            // ACT
            // First call ForgetPasswordEvent to populate data in state
            await cubit.doIntent(const ForgetPasswordEvent(email: testEmail));

            // Wait for async operations
            await Future.delayed(const Duration(milliseconds: 100));

            // ASSERT
            // Verify navigation event was emitted after successful API call
            expect(events.length, greaterThan(0));
            expect(events.last, isA<NavigateToVerifyOtpCode>());
            expect((events.last as NavigateToVerifyOtpCode).email, testEmail);

            await subscription.cancel();
          },
        );

        test('When call NavigateToVerifyOtpCode directly should '
            'add event to stream', () async {
          // ARRANGE
          final events = <ForgetPasswordEvents>[];
          final subscription = cubit.eventsStream.listen(events.add);

          // ACT
          // Call navigation directly without needing data in state
          await cubit.doIntent(const NavigateToVerifyOtpCode(email: testEmail));
          await Future.delayed(const Duration(milliseconds: 100));

          // ASSERT
          expect(events.length, greaterThan(0));
          expect(events.last, isA<NavigateToVerifyOtpCode>());
          expect((events.last as NavigateToVerifyOtpCode).email, testEmail);

          await subscription.cancel();
        });
      });
    });
  });
}
