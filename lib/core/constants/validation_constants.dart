class ValidationConstants {
  ValidationConstants._();

  static const emailRequired = 'email_required';
  static const invalidEmail = 'invalid_email';

  static const passwordRequired = 'password_required';
  static const passwordMinLength = 'password_min_length';
  static const passwordUpperCase = 'password_uppercase';
  static const passwordLowerCase = 'password_lowercase';
  static const passwordNumber = 'password_number';
  static const passwordSpecialChar = 'password_special_char';

  static const confirmPasswordRequired = 'confirm_password_required';
  static const passwordsDoNotMatch = 'passwords_do_not_match';

  static const phoneNumberRequired = 'phone_number_required';
  static const invalidPhoneNumber = 'invalid_phone_number';

  // -------- OTP --------
  static const pleaseEnterOTPCode = 'please_enter_otp';
  static const otpMustBe6Digits = 'otp_must_be_6_digits';
}
