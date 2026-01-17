sealed class VerifyOtpCodeEvents {
  const VerifyOtpCodeEvents();
}

class VerifyOtpCodeEvent extends VerifyOtpCodeEvents {
  const VerifyOtpCodeEvent({required this.otpCode});

  final String otpCode;
}

class ResendOtpCodeEvent extends VerifyOtpCodeEvents {
  const ResendOtpCodeEvent({required this.email});

  final String email;
}

class NavigateToResetPassword extends VerifyOtpCodeEvents {
  const NavigateToResetPassword();
}
