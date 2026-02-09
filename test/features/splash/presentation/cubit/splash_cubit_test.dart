import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/config/error_handler/error_handler.dart';
import 'package:flower_app/features/splash/domain/use_cases/is_logged_use_case.dart';
import 'package:flower_app/features/splash/presentation/cubit/splash_intents.dart';
import 'package:flower_app/features/splash/presentation/cubit/splash_side_effect.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flower_app/features/splash/presentation/cubit/splash_cubit.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'splash_cubit_test.mocks.dart';

@GenerateMocks([IsLoggedUseCase])
void main() {
  late SplashCubit splashCubit;
  late MockIsLoggedUseCase mockIsLoggedUseCase;

  setUpAll(() {
    mockIsLoggedUseCase = MockIsLoggedUseCase();
    splashCubit = SplashCubit(mockIsLoggedUseCase);
  });

  setUp(() {
    reset(mockIsLoggedUseCase);
  });

  group('Success', () {
    test(
      'Should add NavigateToLoginSideEffect when isLogged is false',
      () async {
        when(
          mockIsLoggedUseCase(),
        ).thenAnswer((_) async => const BaseResponse<bool>.success(false));

        final sideEffects = <SplashSideEffect>[];
        final subscription = splashCubit.sideEffectStream.listen(
          sideEffects.add,
        );
        splashCubit.doIntent(const CheckLoginStatusIntent());

        await Future.delayed(Duration.zero);
        expect(sideEffects.length, 1);
        expect(sideEffects[0], isA<NavigateToLoginSideEffect>());

        await subscription.cancel();
      },
    );
    test('Should add NavigateToHomeSideEffect when isLogged is true', () async {
      when(
        mockIsLoggedUseCase(),
      ).thenAnswer((_) async => const BaseResponse<bool>.success(true));

      final sideEffects = <SplashSideEffect>[];
      final subscription = splashCubit.sideEffectStream.listen(sideEffects.add);
      splashCubit.doIntent(const CheckLoginStatusIntent());

      await Future.delayed(Duration.zero);
      expect(sideEffects.length, 1);
      expect(sideEffects[0], isA<NavigateToHomeSideEffect>());

      await subscription.cancel();
    });
  });

  group('Failure', () {
    test('Should add ErrorSideEffect when exception happen', () async {
      when(mockIsLoggedUseCase()).thenAnswer(
        (_) async => BaseResponse<bool>.failure(
          ErrorHandler.handle(Exception('Exception')),
        ),
      );

      final sideEffects = <SplashSideEffect>[];
      final subscription = splashCubit.sideEffectStream.listen(sideEffects.add);
      splashCubit.doIntent(const CheckLoginStatusIntent());

      await Future.delayed(Duration.zero);
      expect(sideEffects.length, 1);
      expect(sideEffects[0], isA<ErrorSideEffect>());

      await subscription.cancel();
    });
  });
}
