import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:online_exam_app/config/base_state/base_state.dart';
import '../../domain/usecases/forget_password_use_case.dart';
import 'forget_password_state.dart';

@injectable
class ForgetPasswordCubit extends Cubit<ForgetPasswordState> {
  final ForgetPasswordUseCase _forgetPasswordUseCase;

  ForgetPasswordCubit(this._forgetPasswordUseCase)
      : super(const ForgetPasswordState());

  Future<void> forgetPassword(String email) async {
    emit(state.copyWith(
      forgetPasswordState: const BaseState(isLoading: true),
    ));

    final response = await _forgetPasswordUseCase.execute(email: email);

    response.when(
      success: (data) {
        emit(state.copyWith(
          forgetPasswordState: BaseState(data: data),
        ));
      },
      failure: (error) {
        emit(state.copyWith(
          forgetPasswordState: BaseState(
            errorMessage: error.message,
          ),
        ));
      },
    );
  }
}
