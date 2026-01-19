sealed class ResetPasswordEvents {
  const ResetPasswordEvents();
}

class ResetPasswordEvent extends ResetPasswordEvents {
  const ResetPasswordEvent({required this.email, required this.newPassword});

  final String email;
  final String newPassword;
}

class NavigateToLogin extends ResetPasswordEvents {}
