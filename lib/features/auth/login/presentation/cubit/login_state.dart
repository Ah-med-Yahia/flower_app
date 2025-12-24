class LoginStates {
  final bool rememberMe;
  final bool isFieldsValid;

  LoginStates({this.rememberMe = false, this.isFieldsValid = false});

  LoginStates copyWith({bool? isFieldsValid, bool? rememberMe}) {
    return LoginStates(
      isFieldsValid: isFieldsValid ?? this.isFieldsValid,
      rememberMe: rememberMe ?? this.rememberMe,
    );
  }
}
