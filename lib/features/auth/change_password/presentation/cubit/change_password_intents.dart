sealed class ChangePasswordIntents {
  const ChangePasswordIntents();
}

class CurrentPasswordChanged extends ChangePasswordIntents {
  final String currentPassword;
  CurrentPasswordChanged(this.currentPassword);
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
