sealed class ChangePasswordIntents {
  const ChangePasswordIntents();
}

class OldPasswordChanged extends ChangePasswordIntents {
  final String oldaPassword;
  OldPasswordChanged(this.oldaPassword);
}

class NewPasswordChanged extends ChangePasswordIntents {
  final String newPassword;
  NewPasswordChanged(this.newPassword);
}

class ConfirmPasswordChanged extends ChangePasswordIntents {
  final String confirmPassword;
  ConfirmPasswordChanged(this.confirmPassword);
}

class UpdateIntent extends ChangePasswordIntents {}
