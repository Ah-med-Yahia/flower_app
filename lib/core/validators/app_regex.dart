abstract class AppRegex {
  static final Pattern _emailPattern = RegExp(
    r'^[\w\-\.]+@([\w]+\.)+[\w]{2,4}$',
  );
  static final Pattern _passwordPattern = RegExp(r'(?=.*[a-z])');
  static final Pattern _upperCasePattern = RegExp(r'(?=.*[A-Z])');
  static final Pattern _numberPattern = RegExp(r'(?=.*\d)');
  static final Pattern _specialCharacterPattern = RegExp(r'(?=.*[@$#!%*?&])');

  static bool isEmailValid(String email) {
    return _emailPattern.allMatches(email).isNotEmpty;
  }

  /// ================= PASSWORD =================
  static bool hasLowerCase(String password) {
    return _passwordPattern.allMatches(password).isNotEmpty;
  }

  static bool hasUpperCase(String password) {
    return _upperCasePattern.allMatches(password).isNotEmpty;
  }

  static bool hasNumber(String password) {
    return _numberPattern.allMatches(password).isNotEmpty;
  }

  static bool hasSpecialCharacter(String password) {
    return _specialCharacterPattern.allMatches(password).isNotEmpty;
  }

  static bool hasMinLength(String password) {
    return password.length >= 8;
  }

  static bool isPhoneValid(String phone) {
    final trimmed = phone.trim();

    final Pattern localRegex = RegExp(r'^01[0-9]{9}$');

    final Pattern internationalRegex = RegExp(r'^\+201[0-9]{9}$');

    return localRegex.allMatches(trimmed).isNotEmpty ||
        internationalRegex.allMatches(trimmed).isNotEmpty;
  }
}
