import 'dart:async';
import 'dart:developer' as developer;

import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/config/base_state/base_state.dart';
import 'package:flower_app/config/cache_modules/secure_storage_module.dart';
import 'package:flower_app/core/constants/app_text_constants.dart';
import 'package:flower_app/features/auth/change_password/domain/entities/change_password_request_entity/change_password_request_entity.dart';
import 'package:flower_app/features/auth/change_password/domain/entities/change_password_response_entity/change_password_response_entity.dart';
import 'package:flower_app/features/auth/change_password/domain/usecases/change_password_use_case.dart';
import 'package:flower_app/features/auth/change_password/presentation/cubit/change_password_intents.dart';
import 'package:flower_app/features/auth/change_password/presentation/cubit/change_pasword_ui_intents.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'change_password_states.dart';

@injectable
class ChangePasswordCubit extends Cubit<ChangePasswordStates> {
  final ChangePasswordUseCase _passwordUseCase;
  final SecureStorageService _secureStorageService;
  final StreamController<ChangePaswordUiIntents> _streamController =
      StreamController();

  Stream<ChangePaswordUiIntents> get UIInenet => _streamController.stream;

  ChangePasswordCubit(this._passwordUseCase, this._secureStorageService)
    : super(ChangePasswordStates());

  void doIntent(ChangePasswordIntents intent) {
    switch (intent) {
      case OldPasswordChanged():
        emit(
          state.copyWith(
            oldPassword: intent.oldaPassword,
            isvalidForm: _validate(password: intent.oldaPassword),
          ),
        );
        break;
      case NewPasswordChanged():
        emit(
          state.copyWith(
            newPassword: intent.newPassword,
            isvalidForm: _validate(newPassword: intent.newPassword),
          ),
        );
        break;

      case ConfirmPasswordChanged():
        emit(
          state.copyWith(
            confirmPassword: intent.confirmPassword,
            isvalidForm: _validate(confirmPassword: intent.confirmPassword),
          ),
        );
        break;
      case UpdateIntent():
        _updatePawssord();
    }
  }

  bool? _validate({
    String? password,
    String? newPassword,
    String? confirmPassword,
  }) {
    final currentPassword = password ?? state.oldPassword;
    final currentNewPassword = newPassword ?? state.newPassword;
    final currentConfirmPassword = confirmPassword ?? state.confirmPassword;

    final allFieldsFilled =
        currentPassword.isNotEmpty &&
        currentNewPassword.isNotEmpty &&
        currentConfirmPassword.isNotEmpty;

    final passwordsMatch = currentNewPassword == currentConfirmPassword;

    return allFieldsFilled && passwordsMatch;
  }

  Future<void> _updatePawssord() async {
    if (state.oldPassword.trim().isEmpty) {
      _streamController.add(
        ShowErrorIntent(message: AppTextConstants.pleaseEnterYourCurrentPassword),
      );
      return;
    }

    if (state.newPassword.trim().isEmpty) {
      _streamController.add(
        ShowErrorIntent(message: AppTextConstants.pleaseEnterYourNewPassword),
      );
      return;
    }

    if (state.confirmPassword.trim().isEmpty) {
      _streamController.add(
        ShowErrorIntent(message: AppTextConstants.pleaseConfirmYourNewPassword),
      );
      return;
    }

    if (state.newPassword.trim() != state.confirmPassword.trim()) {
      _streamController.add(
        ShowErrorIntent(
          message: AppTextConstants.passwordsDoNotMatch,
        ),
      );
      return;
    }

    if (state.oldPassword.trim() == state.newPassword.trim()) {
      _streamController.add(
        ShowErrorIntent(
          message: AppTextConstants.newPasswordSameAsOld,
        ),
      );
      return;
    }

    _streamController.add(ShowLoadingIntent());

    final request = ChangePasswordRequestEntity(
      password: state.oldPassword.trim(),
      newPassword: state.newPassword.trim(),
    );

    developer.log('Change password request: $request');

    final response = await _passwordUseCase(request);

    response.map(
      success: (response) async {
        developer.log('Password updated successfully');

        if (response.data.token != null && response.data.token!.isNotEmpty) {
          final saveResult = await _secureStorageService.saveAuthTokens(
            accessToken: response.data.token!,
          );
          saveResult.map(
            success: (result) {
              developer.log('New token saved to secure storage');
            },
            failure: (error) {
              developer.log('Failed to save new token: ${error.errorHandler.message}');
            },
          );
        }

        _streamController.add(
          NavigateToEditProfileIntent(
            message: AppTextConstants.passwordUpdatedSuccessfully,
          ),
        );
      },
      failure: (errorHandler) {
        developer.log(
          'Password update failed: ${errorHandler.errorHandler.message}, Code: ${errorHandler.errorHandler.code}',
        );
        _streamController.add(
          ShowErrorIntent(message: errorHandler.errorHandler.message),
        );
      },
    );
  }
}
