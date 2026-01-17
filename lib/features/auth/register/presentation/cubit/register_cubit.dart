import 'dart:async';
import 'dart:developer';
import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/core/constants/app_text_constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'register_events.dart';
import 'register_states.dart';
import 'register_ui_events.dart';
import '../../data/models/register_request/register_request.dart';
import '../../domain/usecases/register_use_case.dart';

@injectable
class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit(this._registerUseCase) : super(RegisterStates());

  final RegisterUseCase _registerUseCase;

  final _uiEventsController = StreamController<RegisterUiEvent>();
  Stream<RegisterUiEvent> get uiEvents => _uiEventsController.stream;

  void doIntent(RegisterEvents intent) {
    switch (intent) {
      case FirstNameChanged():
        emit(
          state.copyWith(
            firstName: intent.firstName,
            isFormValid: _validate(firstName: intent.firstName),
          ),
        );
        break;

      case LastNameChanged():
        emit(
          state.copyWith(
            lastName: intent.lastName,
            isFormValid: _validate(lastName: intent.lastName),
          ),
        );
        break;

      case EmailChanged():
        emit(
          state.copyWith(
            email: intent.email,
            isFormValid: _validate(email: intent.email),
          ),
        );
        break;

      case PasswordChanged():
        emit(
          state.copyWith(
            password: intent.password,
            isFormValid: _validate(password: intent.password),
          ),
        );
        break;

      case ConfirmPasswordChanged():
        emit(
          state.copyWith(
            confirmPassword: intent.confirmPassword,
            isFormValid: _validate(confirmPassword: intent.confirmPassword),
          ),
        );
        break;

      case PhoneNumberChanged():
        emit(
          state.copyWith(
            phoneNumber: intent.phoneNumber,
            isFormValid: _validate(phoneNumber: intent.phoneNumber),
          ),
        );
        break;

      case GenderChanged():
        emit(
          state.copyWith(
            gender: intent.gender,
            isFormValid: _validate(gender: intent.gender),
          ),
        );
        break;

      case SignUpButtonPressed():
        _register();
        break;
    }
  }

  bool _validate({
    String? firstName,
    String? lastName,
    String? email,
    String? password,
    String? confirmPassword,
    String? phoneNumber,
    String? gender,
  }) {
    return (firstName ?? state.firstName).isNotEmpty &&
        (lastName ?? state.lastName).isNotEmpty &&
        (email ?? state.email).isNotEmpty &&
        (password ?? state.password).isNotEmpty &&
        (confirmPassword ?? state.confirmPassword).isNotEmpty &&
        (phoneNumber ?? state.phoneNumber).isNotEmpty &&
        (gender ?? state.gender).isNotEmpty;
  }

  String _normalizeEgyptPhone(String phone) {
    phone = phone.trim().replaceAll(' ', '');

    if (phone.startsWith('01') && phone.length == 11) {
      return '+20${phone.substring(1)}';
    }

    if (phone.startsWith('+20') && phone.length == 13) {
      return phone;
    }

    throw Exception('Invalid phone number format');
  }

  Future<void> _register() async {
    _uiEventsController.add(ShowRegisterLoading());

    late final String formattedPhone;

    try {
      formattedPhone = _normalizeEgyptPhone(state.phoneNumber);
    } catch (e) {
      _uiEventsController.add(
        ShowRegisterError(AppTextConstants.invalidPhoneNumber),
      );
      return;
    }

    final request = RegisterRequestModel(
      firstName: state.firstName.trim(),
      lastName: state.lastName.trim(),
      email: state.email.trim(),
      password: state.password,
      rePassword: state.confirmPassword,
      phone: formattedPhone,
      gender: state.gender.toLowerCase(),
    );

    log('REGISTER REQUEST => ${request.toJson()}');

    final result = await _registerUseCase(request);

    result.map(
      success: (_) {
        _uiEventsController.add(NavigateToLogin());
      },
      failure: (e) {
        _uiEventsController.add(
          ShowRegisterError(
            e.errorHandler.message ?? AppTextConstants.failedToRegister,
          ),
        );
      },
    );
  }

  @override
  Future<void> close() {
    _uiEventsController.close();
    return super.close();
  }
}
