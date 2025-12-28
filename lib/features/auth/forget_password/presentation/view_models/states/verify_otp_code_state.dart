import 'package:equatable/equatable.dart';

import '../../../../../../config/base_state/base_state.dart';
import '../../../domain/entities/verify_otp_code_entity.dart';

class VerifyOtpCodeState extends Equatable {
  final BaseState<VerifyOtpCodeEntity> verifyOtpCodeState;
  final BaseState<VerifyOtpCodeEntity> resendOtpCodeState;

  const VerifyOtpCodeState({
    BaseState<VerifyOtpCodeEntity>? verifyOtpCodeState,
    BaseState<VerifyOtpCodeEntity>? resendOtpCodeState,
  }) : verifyOtpCodeState =
           verifyOtpCodeState ?? const BaseState<VerifyOtpCodeEntity>(),
       resendOtpCodeState =
           resendOtpCodeState ?? const BaseState<VerifyOtpCodeEntity>();

  VerifyOtpCodeState copyWith({
    BaseState<VerifyOtpCodeEntity>? verifyOtpCodeState,
    BaseState<VerifyOtpCodeEntity>? resendOtpCodeState,
  }) => VerifyOtpCodeState(
    verifyOtpCodeState: verifyOtpCodeState ?? this.verifyOtpCodeState,
    resendOtpCodeState: resendOtpCodeState ?? this.resendOtpCodeState,
  );

  @override
  List<Object?> get props => [verifyOtpCodeState, resendOtpCodeState];
}
