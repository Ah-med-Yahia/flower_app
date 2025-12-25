import 'package:bloc_test/bloc_test.dart';
import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/config/error_handler/error_handler.dart';
import 'package:flower_app/features/auth/login/domain/entities/login_request_entity.dart';
import 'package:flower_app/features/auth/login/domain/usecases/login_use_case.dart';
import 'package:flower_app/features/auth/login/presentation/cubit/login_cubit.dart';
import 'package:flower_app/features/auth/login/presentation/cubit/login_intents.dart';
import 'package:flower_app/features/auth/login/presentation/cubit/login_state.dart';
import 'package:flower_app/features/auth/login/presentation/cubit/login_ui_events.dart';
import 'package:test/test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'login_cubit_test.mocks.dart';

@GenerateMocks([LoginUseCase])
void main() {
  late MockLoginUseCase mockLoginUseCase;
  late LoginCubit cubit;

  setUp(() {
    mockLoginUseCase = MockLoginUseCase();
    cubit = LoginCubit(mockLoginUseCase);
  });

  tearDown(() {
    cubit.close();
  });

  final testLoginRequest = LoginRequestEntity(
    email: 'test@example.com',
    password: 'Password123',
  );

  group('LoginCubit Test Cases', () {
    test('initial state should be LoginStates with default values', () {
      expect(cubit.state, isA<LoginStates>());
      expect(cubit.state.isFieldsValid, false);
      expect(cubit.state.rememberMe, false);
    });

    group('ValidateFields intent ', () {
      blocTest<LoginCubit, LoginStates>(
        'should emit isFieldsValid = true when email and password are valid',
        build: () => cubit,
        act: (cubit) =>
            cubit.doIntent(ValidateFields('test@example.com', 'Password123#')),
        expect: () => [LoginStates(isFieldsValid: true, rememberMe: false)],
      );

      blocTest<LoginCubit, LoginStates>(
        'should emit isFieldsValid = false when email is invalid',
        build: () => cubit,
        act: (cubit) =>
            cubit.doIntent(ValidateFields('invalid-email', 'Password123#')),
        expect: () => [LoginStates(isFieldsValid: false, rememberMe: false)],
      );

      blocTest<LoginCubit, LoginStates>(
        'should emit isFieldsValid = false when password is invalid',
        build: () => cubit,
        act: (cubit) =>
            cubit.doIntent(ValidateFields('test@example.com', '123')),
        expect: () => [LoginStates(isFieldsValid: false, rememberMe: false)],
      );
    });

    group('RememberMeToggled intent ', () {
      blocTest<LoginCubit, LoginStates>(
        'should toggle rememberMe from false to true',
        build: () => cubit,
        act: (cubit) => cubit.doIntent(RememberMeToggled()),
        expect: () => [LoginStates(isFieldsValid: false, rememberMe: true)],
      );

      blocTest<LoginCubit, LoginStates>(
        'should toggle rememberMe from true to false',
        build: () => cubit,
        seed: () => LoginStates(isFieldsValid: false, rememberMe: true),
        act: (cubit) => cubit.doIntent(RememberMeToggled()),
        expect: () => [LoginStates(isFieldsValid: false, rememberMe: false)],
      );
    });

    group('LoginSubmitted intent Success Cases', () {
      test(
        'should emit ShowLoading and NavigateToHome events on successful login',
        () async {
          when(
            mockLoginUseCase.call(any, any),
          ).thenAnswer((_) async => BaseResponse<void>.success(null));

          final future = expectLater(
            cubit.uiEvents,
            emitsInOrder([isA<ShowLoading>(), isA<NavigateToHome>()]),
          );

          await cubit.doIntent(LoginSubmitted(testLoginRequest));

          await future;

          verify(mockLoginUseCase.call(testLoginRequest, false)).called(1);
        },
      );
    });

    group('LoginSubmitted intent Failure Cases', () {
      final errorHandler = ErrorHandler.handle('eror');

      test(
        'should emit ShowLoading then ShowErrorMessage UI events on failure',
        () async {
          when(
            mockLoginUseCase.call(any, any),
          ).thenAnswer((_) async => BaseResponse.failure(errorHandler));

          final uiEvents = <LoginUIEvent>[];
          final subscription = cubit.uiEvents.listen(uiEvents.add);

          await cubit.doIntent(LoginSubmitted(testLoginRequest));

          await Future.delayed(Duration.zero);

          expect(uiEvents.length, 2);
          expect(uiEvents[0], isA<ShowLoading>());
          expect(uiEvents[1], isA<ShowErrorMessage>());

          await subscription.cancel();
        },
      );
    });
  });
}
