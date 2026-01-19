sealed class ForgetPasswordEvents {
  const ForgetPasswordEvents();
}

class ForgetPasswordEvent extends ForgetPasswordEvents {
  const ForgetPasswordEvent({required this.email});

  final String email;
}

class NavigateToVerifyOtpCode extends ForgetPasswordEvents {
  final String email;

  const NavigateToVerifyOtpCode({required this.email});
}
