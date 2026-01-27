import 'dart:async';
import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/config/base_state/base_state.dart';
import 'package:flower_app/core/constants/app_text_constants.dart';
import 'package:flower_app/features/auth/change_password/domain/entities/change_password_request_entity/change_password_request_entity.dart';
import 'package:flower_app/features/auth/change_password/domain/usecases/change_password_use_case.dart';
import 'package:flower_app/features/auth/change_password/presentation/cubit/change_password_intents.dart';
import 'package:flower_app/features/auth/change_password/presentation/cubit/change_pasword_ui_intents.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'change_password_states.dart';

@injectable
class ChangePasswordCubit extends Cubit<ChangePasswordStates> {
  final ChangePasswordUseCase _passwordUseCase;
  final StreamController<ChangePaswordUiIntents> _streamController =
      StreamController();

  Stream<ChangePaswordUiIntents> get uiInenet => _streamController.stream;

  ChangePasswordCubit(this._passwordUseCase) : super(const ChangePasswordStates());

  void doIntent(ChangePasswordIntents intent) {
    switch (intent) {
      case CurrentPasswordChanged():
        _updateCurrentPassword(intent.currentPassword);
        break;
      case NewPasswordChanged():
        _updateNewPassword(intent.newPassword);
        break;

      case ConfirmPasswordChanged():
        _updateConfirmPassword(intent.confirmPassword);
        break;
      case UpdateIntent():
        _updatePawssord();
    }
  }

  void _updateCurrentPassword(String currentPassword) {
    emit(
      state.copyWith(
        currentPassword: currentPassword,
        isValidForm: _validate(currentPassword: currentPassword),
      ),
    );
  }

  void _updateNewPassword(String newPassword) {
    emit(
      state.copyWith(
        newPassword: newPassword,
        isValidForm: _validate(newPassword: newPassword),
      ),
    );
  }

  void _updateConfirmPassword(String confirmPassword) {
    emit(
      state.copyWith(
        confirmPassword: confirmPassword,
        isValidForm: _validate(confirmPassword: confirmPassword),
      ),
    );
  }

  bool? _validate({
    String? currentPassword,
    String? newPassword,
    String? confirmPassword,
  }) {
    final current = currentPassword ?? state.currentPassword;
    final currentNewPassword = newPassword ?? state.newPassword;
    final currentConfirmPassword = confirmPassword ?? state.confirmPassword;

    final allFieldsFilled =
        current.isNotEmpty &&
        currentNewPassword.isNotEmpty &&
        currentConfirmPassword.isNotEmpty;

    final passwordsMatch = currentNewPassword == currentConfirmPassword;

    return allFieldsFilled && passwordsMatch;
  }

  Future<void> _updatePawssord() async {
    if (state.currentPassword.trim().isEmpty) {
      _streamController.add(
       const ShowErrorIntent(
          message: AppTextConstants.pleaseEnterYourCurrentPassword,
        ),
      );
      return;
    }

    if (state.newPassword.trim().isEmpty) {
      _streamController.add(
      const  ShowErrorIntent(message: AppTextConstants.pleaseEnterYourNewPassword),
      );
      return;
    }

    if (state.confirmPassword.trim().isEmpty) {
      _streamController.add(
      const  ShowErrorIntent(message: AppTextConstants.pleaseConfirmYourNewPassword),
      );
      return;
    }

    if (state.newPassword.trim() != state.confirmPassword.trim()) {
      _streamController.add(
      const  ShowErrorIntent(message: AppTextConstants.passwordsDoNotMatch),
      );
      return;
    }

    if (state.currentPassword.trim() == state.newPassword.trim()) {
      _streamController.add(
       const ShowErrorIntent(message: AppTextConstants.newPasswordSameAsOld),
      );
      return;
    }

    _streamController.add(ShowLoadingIntent());

    final request = ChangePasswordRequestEntity(
      password: state.currentPassword.trim(),
      newPassword: state.newPassword.trim(),
    );

    final response = await _passwordUseCase(request);

    response.map(
      success: (response) async {
        _streamController.add(
         const NavigateToEditProfileIntent(
            message: AppTextConstants.passwordUpdatedSuccessfully,
          ),
        );
      },
      failure: (errorHandler) {
        _streamController.add(
          ShowErrorIntent(message: errorHandler.errorHandler.message),
        );
      },
    );
  }
}
