import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/features/auth/logout/domain/usecases/logout_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../../config/base_state/base_state.dart';
import 'logout_events.dart';
import 'logout_states.dart';

@injectable
class LogoutCubit extends Cubit<LogoutStates> {
  LogoutCubit(this._logoutUseCase) : super(LogoutStates());

  final LogoutUsecase _logoutUseCase;

  void onEvent(LogoutEvents event) {
    switch (event) {
      case LogoutRequested():
        _logout();
    }
  }

  void _logout() async {
    emit(
      state.copyWith(
        logoutState: const BaseState(
          isLoading: true,
          data: null,
          errorMessage: null,
        ),
      ),
    );

    final response = await _logoutUseCase.call();

    response.when(
      success: (data) {
        emit(
          state.copyWith(
            logoutState: const BaseState(
              isLoading: false,
              data: null,
              errorMessage: null,
            ),
          ),
        );
      },
      failure: (failure) {
        emit(
          state.copyWith(
            logoutState: BaseState(
              isLoading: false,
              errorMessage: failure.message,
              data: null,
            ),
          ),
        );
      },
    );
  }
}
