import 'package:flower_app/features/auth/login/domain/entities/login_request_entity.dart';

sealed class LoginIntents {}

class LoginSubmitted extends LoginIntents {
  final LoginRequestEntity loginRequestEntity;
  LoginSubmitted(this.loginRequestEntity);
}

class ValidateFields extends LoginIntents {
  final String email;
  final String password;

  ValidateFields(this.email, this.password);
}

class RememberMeToggled extends LoginIntents {}