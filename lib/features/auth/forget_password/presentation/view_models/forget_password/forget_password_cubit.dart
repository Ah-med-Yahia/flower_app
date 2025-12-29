import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/usecases/forget_password_use_case.dart';
import 'forget_password_events.dart';
import 'forget_password_state.dart';

@injectable
class ForgetPasswordCubit extends Cubit<ForgetPasswordState> {
  ForgetPasswordCubit(this._forgetPasswordUseCase)
    : super(ForgetPasswordState());

  final ForgetPasswordUseCase _forgetPasswordUseCase;
  final StreamController<ForgetPasswordEvents> _eventsStream =
      StreamController.broadcast();

  Stream<ForgetPasswordEvents> get eventsStream => _eventsStream.stream;

  Future<void> doIntent(ForgetPasswordEvents event) async {
    switch (event) {
      case ForgetPasswordEvent():
        _handleForgetPasswordEvent(email: event.email);
        // TODO: Remove this debug print statement Before deploying
        if (kDebugMode) print('Email: ${event.email}');
      case NavigateToVerifyOtpCode():
        _navigation(event);
    }
  }

  Future<void> _apiCall(String email) async {
    final result = await _forgetPasswordUseCase.execute(email: email);
    result.when(
      success: (data) {
        emit(
          state.copyWith(
            forgetPasswordState: state.forgetPasswordState.copyWith(
              data: data,
              isLoading: false,
            ),
          ),
        );
        // Trigger navigation after successful API response
        _navigation(NavigateToVerifyOtpCode(email: email));
      },
      failure: (error) => {
        emit(
          state.copyWith(
            forgetPasswordState: state.forgetPasswordState.copyWith(
              errorMessage: error.message,
              isLoading: false,
            ),
          ),
        ),
      },
    );
  }

  void _handleForgetPasswordEvent({required String email}) async {
    emit(
      state.copyWith(
        forgetPasswordState: state.forgetPasswordState.copyWith(
          isLoading: true,
        ),
      ),
    );
    await _apiCall(email);
  }

  void _navigation(NavigateToVerifyOtpCode event) {
    _eventsStream.add(NavigateToVerifyOtpCode(email: event.email));
  }

  @override
  Future<void> close() {
    _eventsStream.close();
    return super.close();
  }
}
