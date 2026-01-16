import 'dart:async';

import 'package:flower_app/core/validators/app_validators.dart';
import 'package:flower_app/features/auth/login/domain/entities/login_request_entity.dart';
import 'package:flower_app/features/auth/login/presentation/cubit/login_ui_events.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../domain/usecases/login_use_case.dart';
import 'login_intents.dart';
import 'login_state.dart';

@injectable
class LoginCubit extends Cubit<LoginStates> {
  LoginCubit(this._loginUseCase) : super(LoginStates());
  final LoginUseCase _loginUseCase;
  final _uiEventController = StreamController<LoginUIEvent>.broadcast();
  Stream<LoginUIEvent> get uiEvents => _uiEventController.stream;

  Future<void> doIntent(LoginIntents intent) async {
    switch (intent) {
      case LoginSubmitted(:final loginRequestEntity):
        _performLogin(loginRequestEntity);
      case ValidateFields(:final email, :final password):
        _validateForm(email: email, password: password);
      case RememberMeToggled():
        _rememberMe();
    }
  }

  Future<void> _performLogin(LoginRequestEntity loginReq) async {
    _uiEventController.add(ShowLoading());

    final response = await _loginUseCase(loginReq, state.rememberMe);

    response.map(
      success: (s) {
        _uiEventController.add(NavigateToHome());
      },
      failure: (f) {
        _uiEventController.add(ShowErrorMessage(f.errorhandeler.message ?? 'Something went wrong'));
      },
    );
  }

  void _validateForm({required String email, required String password}) {
    bool isValid =
        AppValidators.validateEmail(email) == null &&
        AppValidators.validatePassword(password) == null;
    emit(state.copyWith(isFieldsValid: isValid));
  }

  void _rememberMe() {
    emit(state.copyWith(rememberMe: !state.rememberMe));
  }

  @override
  Future<void> close() {
    _uiEventController.close();
    return super.close();
  }
}
