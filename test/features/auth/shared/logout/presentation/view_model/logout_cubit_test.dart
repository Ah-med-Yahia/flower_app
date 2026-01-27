import 'package:bloc_test/bloc_test.dart';
import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/config/error_handler/error_handler.dart';
import 'package:flower_app/features/auth/shared/logout/domain/usecases/logout_usecase.dart';
import 'package:flower_app/features/auth/shared/logout/presentation/view_model/logout_cubit.dart';
import 'package:flower_app/features/auth/shared/logout/presentation/view_model/logout_events.dart';
import 'package:flower_app/features/auth/shared/logout/presentation/view_model/logout_states.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'logout_cubit_test.mocks.dart';

@GenerateMocks([LogoutUsecase])
Future<void> main() async {
  late LogoutCubit cubit;
  late MockLogoutUsecase mockUseCase;

  setUp(() {
    mockUseCase = MockLogoutUsecase();
    cubit = LogoutCubit(mockUseCase);
  });

  tearDown(() => cubit.close());

  group('logout', () {
    test('initial state should have null logoutState', () {
      expect(cubit.state.logoutState, isNull);
    });

    blocTest<LogoutCubit, LogoutStates>(
      'emits [loading, success] when logout succeeds',
      build: () {
        when(
          mockUseCase.call(),
        ).thenAnswer((_) async => const BaseResponse.success(null));
        return cubit;
      },
      act: (cubit) => cubit.onEvent(LogoutRequested()),
      expect: () => [
        predicate<LogoutStates>((state) {
          return state.logoutState?.isLoading == true &&
              state.logoutState?.errorMessage == null;
        }),
        predicate<LogoutStates>((state) {
          return state.logoutState?.isLoading == false &&
              state.logoutState?.errorMessage == null;
        }),
      ],
      verify: (_) {
        verify(mockUseCase.call()).called(1);
      },
    );

    blocTest<LogoutCubit, LogoutStates>(
      'emits [loading, failure] when logout fails',
      build: () {
        when(mockUseCase.call()).thenAnswer(
          (_) async => BaseResponse.failure(
            ErrorHandler.handle(Exception('Logout failed')),
          ),
        );
        return cubit;
      },
      act: (cubit) => cubit.onEvent(LogoutRequested()),
      expect: () => [
        predicate<LogoutStates>((state) {
          return state.logoutState?.isLoading == true &&
              state.logoutState?.errorMessage == null;
        }),
        predicate<LogoutStates>((state) {
          return state.logoutState?.isLoading == false &&
              state.logoutState?.errorMessage != null;
        }),
      ],
      verify: (_) {
        verify(mockUseCase.call()).called(1);
      },
    );
  });
}
