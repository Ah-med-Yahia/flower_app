import 'dart:async';

import 'package:flower_app/features/auth/forget_password/presentation/view_models/reset_password/reset_password_events.dart';
import 'package:flower_app/features/auth/forget_password/presentation/view_models/reset_password/reset_password_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../config/base_response/base_response.dart';
import '../../../domain/usecases/reset_password_use_case.dart';

@injectable
class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  ResetPasswordCubit(this._resetPasswordUseCase) : super(ResetPasswordState());
  final ResetPasswordUseCase _resetPasswordUseCase;
  final StreamController<ResetPasswordEvents> _eventsStream =
      StreamController.broadcast();

  Stream<ResetPasswordEvents> get eventsStream => _eventsStream.stream;

  Future<void> doIntent(ResetPasswordEvents event) async {
    switch (event) {
      case ResetPasswordEvent():
        await _apiCall(email: event.email, newPassword: event.newPassword);
      case NavigateToLogin():
    }
  }

  void _handleNavigation() {
    _eventsStream.add(NavigateToLogin());
  }

  Future<void> _apiCall({
    required String email,
    required String newPassword,
  }) async {
    emit(
      state.copyWith(
        resetPasswordState: state.resetPasswordState.copyWith(isLoading: true),
      ),
    );
    final result = await _resetPasswordUseCase.execute(
      email: email,
      newPassword: newPassword,
    );
    result.when(
      success: (data) {
        emit(
          state.copyWith(
            resetPasswordState: state.resetPasswordState.copyWith(
              data: data,
              isLoading: false,
            ),
          ),
        );
        _handleNavigation();
      },
      failure: (error) {
        emit(
          state.copyWith(
            resetPasswordState: state.resetPasswordState.copyWith(
              errorMessage: error.message,
              isLoading: false,
            ),
          ),
        );
      },
    );
  }

  @override
  Future<void> close() {
    _eventsStream.close();
    return super.close();
  }
}
