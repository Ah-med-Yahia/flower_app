sealed class RegisterUiEvent {}

class ShowRegisterLoading extends RegisterUiEvent {}

class ShowRegisterError extends RegisterUiEvent {
  final String message;
  ShowRegisterError(this.message);
}

class NavigateTologin extends RegisterUiEvent {}
