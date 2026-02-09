import 'dart:async';

import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/features/splash/presentation/cubit/splash_intents.dart';
import 'package:flower_app/features/splash/presentation/cubit/splash_side_effect.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../domain/use_cases/is_logged_use_case.dart';
import 'splash_state.dart';

@Injectable()
class SplashCubit extends Cubit<SplashState> {
  final IsLoggedUseCase _isLoggedUseCase;

  final _sideEffectController = StreamController<SplashSideEffect>();
  Stream<SplashSideEffect> get sideEffectStream => _sideEffectController.stream;

  SplashCubit(this._isLoggedUseCase) : super(SplashState());

  void doIntent(SplashIntents intent) {
    switch (intent) {
      case CheckLoginStatusIntent():
        _checkLoginStatus();
    }
  }

  void _checkLoginStatus() async {
    final response = await _isLoggedUseCase();
    response.when(
      success: (isLoggedIn) {
        if (isLoggedIn) {
          _sideEffectController.add(NavigateToHomeSideEffect());
        } else {
          _sideEffectController.add(NavigateToLoginSideEffect());
        }
      },
      failure: (failure) =>
          _sideEffectController.add(ErrorSideEffect(failure.message)),
    );
  }

  @override
  Future<void> close() {
    _sideEffectController.close();
    return super.close();
  }
}
