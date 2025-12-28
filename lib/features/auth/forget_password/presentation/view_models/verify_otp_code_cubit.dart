import 'dart:async';

import 'package:flower_app/features/auth/forget_password/presentation/view_models/states/verify_otp_code_state.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../../config/base_state/base_state.dart';
import '../../domain/usecases/otp_verification_use_case.dart';
import 'events/forget_password_events.dart';
import 'events/verify_otp_code_events.dart';
import 'forget_password_cubit.dart';

@injectable
class VerifyOtpCodeCubit extends Cubit<VerifyOtpCodeState> {
  VerifyOtpCodeCubit(this._otpVerificationUseCase, this._forgetPasswordCubit)
    : super(VerifyOtpCodeState());

  final OtpVerificationUseCase _otpVerificationUseCase;
  final ForgetPasswordCubit _forgetPasswordCubit;
  final StreamController<VerifyOtpCodeEvents> _eventsStream =
      StreamController.broadcast();

  Stream<VerifyOtpCodeEvents> get eventsStream => _eventsStream.stream;

  doIntent(VerifyOtpCodeEvents event) async {
    debugPrint('🎯 [Cubit] Received intent: $event');
    switch (event) {
      case VerifyOtpCodeEvent():
        debugPrint(
          '🔐 [Cubit] Handling VerifyOtpCodeEvent with code: ${event.otpCode}',
        );
        _handleVerifyOtpCodeEvent(code: event.otpCode);
      case ResendOtpCodeEvent():
        debugPrint('🔄 [Cubit] Handling ResendOtpCodeEvent');
        _handleResendOtpCodeEvent(email: event.email);
        _eventsStream.add(ResendOtpCodeEvent(email: event.email));
      case NavigateToResetPassword():
        debugPrint('➡️ [Cubit] Handling NavigateToResetPassword');
        _eventsStream.add(NavigateToResetPassword());
    }
  }

  void _handleVerifyOtpCodeEvent({required String code}) async {
    emit(
      state.copyWith(
        verifyOtpCodeState: state.verifyOtpCodeState.copyWith(isLoading: true),
      ),
    );
    await _apiCall(code);
  }

  void _handleResendOtpCodeEvent({required String email}) async {
    emit(
      state.copyWith(
        resendOtpCodeState: state.resendOtpCodeState.copyWith(isLoading: true),
      ),
    );
    await _forgetPasswordCubit.doIntent(ForgetPasswordEvent(email: email));
  }

  Future<void> _apiCall(String resetCode) async {
    debugPrint('📡 [Cubit] Making API call with code: $resetCode');
    final result = await _otpVerificationUseCase.execute(otpCode: resetCode);
    result.when(
      success: (data) {
        debugPrint('✅ [Cubit] API Success - Status: ${data.status}');
        emit(
          state.copyWith(
            verifyOtpCodeState: BaseState(
              data: data,
              isLoading: false,
              errorMessage: null, // Explicitly clear error
            ),
          ),
        );
        // Trigger navigation after successful API response
        debugPrint('🚀 [Cubit] Adding NavigateToResetPassword event to stream');
        _eventsStream.add(NavigateToResetPassword());
      },
      failure: (error) {
        debugPrint('❌ [Cubit] API Failure - Error: ${error.message}');
        emit(
          state.copyWith(
            verifyOtpCodeState: state.verifyOtpCodeState.copyWith(
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
