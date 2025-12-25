import 'package:equatable/equatable.dart';
import '../../../../../../config/base_state/base_state.dart';
import '../../../domain/entities/forget_password_entity.dart';

class ForgetPasswordState extends Equatable {
  ForgetPasswordState({BaseState<ForgetPasswordEntity>? forgetPasswordState})
    : forgetPasswordState =
          forgetPasswordState ?? BaseState<ForgetPasswordEntity>();

  final BaseState<ForgetPasswordEntity> forgetPasswordState;

  ForgetPasswordState copyWith({
    BaseState<ForgetPasswordEntity>? forgetPasswordState,
  }) => ForgetPasswordState(
    forgetPasswordState: forgetPasswordState ?? this.forgetPasswordState,
  );

  @override
  List<Object?> get props => [forgetPasswordState];
}
