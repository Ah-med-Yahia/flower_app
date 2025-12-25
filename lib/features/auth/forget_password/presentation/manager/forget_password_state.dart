import 'package:equatable/equatable.dart';
import 'package:online_exam_app/config/base_state/base_state.dart';
import '../../domain/entities/forget_password_entity.dart';

class ForgetPasswordState extends Equatable {
  final BaseState<ForgetPasswordEntity> forgetPasswordState;

  const ForgetPasswordState({
    this.forgetPasswordState = const BaseState(),
  });

  ForgetPasswordState copyWith({
    BaseState<ForgetPasswordEntity>? forgetPasswordState,
  }) {
    return ForgetPasswordState(
      forgetPasswordState: forgetPasswordState ?? this.forgetPasswordState,
    );
  }

  @override
  List<Object?> get props => [forgetPasswordState];
}
