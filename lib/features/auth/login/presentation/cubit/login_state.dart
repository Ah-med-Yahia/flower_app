import 'package:equatable/equatable.dart';

class LoginStates extends Equatable {
  final bool rememberMe;
  final bool isFieldsValid;

  const LoginStates({this.rememberMe = false, this.isFieldsValid = false});

  LoginStates copyWith({bool? isFieldsValid, bool? rememberMe}) {
    return LoginStates(
      isFieldsValid: isFieldsValid ?? this.isFieldsValid,
      rememberMe: rememberMe ?? this.rememberMe,
    );
  }

  @override
  List<Object?> get props => [rememberMe, isFieldsValid];
}
