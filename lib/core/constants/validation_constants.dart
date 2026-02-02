import 'package:easy_localization/easy_localization.dart';

class ValidationConstants {
  ValidationConstants._();

  static String get noEmailAvailable => 'validation.noEmailAvailable'.tr();

  static String get emailRequired => 'validation.emailRequired'.tr();

  static String get invalidEmail => 'validation.invalidEmail'.tr();

  static String get passwordRequired => 'validation.passwordRequired'.tr();

  static String get passwordMinLength => 'validation.passwordMinLength'.tr();

  static String get passwordUpperCase => 'validation.passwordUpperCase'.tr();

  static String get passwordLowerCase => 'validation.passwordLowerCase'.tr();

  static String get passwordNumber => 'validation.passwordNumber'.tr();

  static String get passwordSpecialChar =>
      'validation.passwordSpecialChar'.tr();

  static String get confirmPasswordRequired =>
      'validation.confirmPasswordRequired'.tr();

  static String get passwordsDoNotMatch =>
      'validation.passwordsDoNotMatch'.tr();

  static String get phoneNumberRequired =>
      'validation.phoneNumberRequired'.tr();

  static String get invalidPhoneNumber => 'validation.invalidPhoneNumber'.tr();

  //----------------------VERIFY-OTP----------------------//
  static String get pleaseEnterOTPCode => 'validation.pleaseEnterOTPCode'.tr();

  static String get otpMustBe6Digits => 'validation.otpMustBe6Digits'.tr();
}
