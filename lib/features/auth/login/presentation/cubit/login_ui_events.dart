sealed class LoginUIEvent {}

class ShowLoading extends LoginUIEvent {}

class ShowErrorMessage extends LoginUIEvent {
  final String message;
  ShowErrorMessage(this.message);
}

class NavigateToHome extends LoginUIEvent {}
