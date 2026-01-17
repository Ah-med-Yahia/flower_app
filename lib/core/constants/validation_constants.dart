class ValidationConstants {
  ValidationConstants._();

  static const String emailRequired = 'Email is required';
  static const String invalidEmail = 'Enter a valid email address';
  static const String passwordRequired = 'Password is required';
  static const String passwordMinLength =
      'Password must be at least 8 characters';
  static const String passwordUpperCase =
      'Password must contain at least one uppercase letter';
  static const String passwordLowerCase =
      'Password must contain at least one lowercase letter';
  static const String passwordNumber =
      'Password must contain at least one number';
  static const String passwordSpecialChar =
      'Password must contain at least one special character';
  static const String confirmPasswordRequired = 'Please confirm your password';
  static const String passwordsDoNotMatch = 'Passwords do not match';
  static const String phoneNumberRequired = 'Phone number is required';
  static const String invalidPhoneNumber = 'Enter a valid phone number';
}
