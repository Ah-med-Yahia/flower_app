import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:online_exam_app/config/base_response/base_response.dart';
import 'package:online_exam_app/config/base_state/base_state.dart';
import 'package:online_exam_app/config/error_handler/error_handler.dart';
import 'package:online_exam_app/features/auth/forget_password/domain/entities/forget_password_entity.dart';
import 'package:online_exam_app/features/auth/forget_password/domain/usecases/forget_password_use_case.dart';
import 'package:online_exam_app/features/auth/forget_password/presentation/manager/forget_password_cubit.dart';
import 'package:online_exam_app/features/auth/forget_password/presentation/manager/forget_password_state.dart';

import 'forget_password_cubit_test.mocks.dart';

@GenerateMocks([ForgetPasswordUseCase])
void main() {
  late ForgetPasswordCubit cubit;
  late MockForgetPasswordUseCase mockForgetPasswordUseCase;

  // Test constants
  const tEmail = 'test@example.com';
  const tMessage = 'Reset code sent successfully';
  const tInfo = 'Check your email';

  setUp(() {
    mockForgetPasswordUseCase = MockForgetPasswordUseCase();
    cubit = ForgetPasswordCubit(mockForgetPasswordUseCase);
  });

  tearDown(() {
    cubit.close();
  });

  group('ForgetPasswordCubit', () {
    test('initial state should be ForgetPasswordState with empty BaseState', () {
      expect(cubit.state, const ForgetPasswordState());
      expect(cubit.state.forgetPasswordState.isLoading, false);
      expect(cubit.state.forgetPasswordState.data, null);
      expect(cubit.state.forgetPasswordState.errorMessage, null);
    });

    group('forgetPassword', () {
      blocTest<ForgetPasswordCubit, ForgetPasswordState>(
        'emits [loading, success] when forgetPassword succeeds',
        build: () {
          const entity = ForgetPasswordEntity(
            message: tMessage,
            info: tInfo,
          );
          when(mockForgetPasswordUseCase.execute(email: tEmail))
              .thenAnswer((_) async => const BaseResponse.success(entity));
          return cubit;
        },
        act: (cubit) => cubit.forgetPassword(tEmail),
        expect: () => [
          ForgetPasswordState(
            forgetPasswordState: const BaseState(isLoading: true),
          ),
          const ForgetPasswordState(
            forgetPasswordState: BaseState(
              data: ForgetPasswordEntity(
                message: tMessage,
                info: tInfo,
              ),
            ),
          ),
        ],
        verify: (_) {
          verify(mockForgetPasswordUseCase.execute(email: tEmail)).called(1);
        },
      );

      blocTest<ForgetPasswordCubit, ForgetPasswordState>(
        'emits [loading, error] when forgetPassword fails',
        build: () {
          final errorHandler = ErrorHandler.handle(Exception('Network error'));
          when(mockForgetPasswordUseCase.execute(email: tEmail))
              .thenAnswer((_) async => BaseResponse.failure(errorHandler));
          return cubit;
        },
        act: (cubit) => cubit.forgetPassword(tEmail),
        expect: () => [
          ForgetPasswordState(
            forgetPasswordState: const BaseState(isLoading: true),
          ),
          ForgetPasswordState(
            forgetPasswordState: BaseState(
              errorMessage: ErrorHandler.handle(Exception('Network error')).message,
            ),
          ),
        ],
        verify: (_) {
          verify(mockForgetPasswordUseCase.execute(email: tEmail)).called(1);
        },
      );
    });
  });
}
