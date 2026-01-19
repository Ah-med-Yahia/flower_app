import 'package:equatable/equatable.dart';

import '../../../../../../config/base_state/base_state.dart';
import '../../../domain/entities/reset_password_entity.dart';

class ResetPasswordState extends Equatable {
  final BaseState<ResetPasswordEntity> resetPasswordState;

  const ResetPasswordState({BaseState<ResetPasswordEntity>? resetPasswordState})
    : resetPasswordState =
          resetPasswordState ?? const BaseState<ResetPasswordEntity>();

  ResetPasswordState copyWith({
    BaseState<ResetPasswordEntity>? resetPasswordState,
  }) => ResetPasswordState(
    resetPasswordState: resetPasswordState ?? this.resetPasswordState,
  );

  @override
  List<Object?> get props => [resetPasswordState];
}
