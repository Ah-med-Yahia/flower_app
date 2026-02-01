import 'package:easy_localization/easy_localization.dart';

class ErrorsConstant {
  ErrorsConstant._();

  static String get badRequestError => 'errors.badRequest'.tr();

  static String get noContent => 'errors.noContent'.tr();

  static String get forbiddenError => 'errors.forbidden'.tr();

  static String get unauthorizedError => 'errors.unauthorized'.tr();

  static String get notFoundError => 'errors.notFound'.tr();

  static String get conflictError => 'errors.conflict'.tr();

  static String get internalServerError => 'errors.internalServer'.tr();

  static String get unknownError => 'errors.unknown'.tr();

  static String get timeoutError => 'errors.timeout'.tr();

  static String get defaultError => 'errors.default'.tr();

  static String get noInternetError => 'errors.noInternet'.tr();

  static String get loadingMessage => 'common.loading'.tr();

  static String get retryAgainMessage => 'common.retry'.tr();

  static String get ok => 'common.ok'.tr();

  //-------------------------- AUTH ERROR --------------------------//
  static String get authenticationCheckError =>
      'errors.authenticationCheck'.tr();

  //-------------------------- CACHE ERROR --------------------------//
  static String get cacheError => 'errors.cache'.tr();

  static String get noCacheDataAvailableError =>
      'errors.noCacheDataAvailable'.tr();

  static String get failedToLoadCachedDataError =>
      'errors.failedToLoadCachedData'.tr();

  //-------------------------- SESSION ERROR --------------------------//
  static String get userNotLoggedInError => 'errors.userNotLoggedIn'.tr();

  static String get sessionExpiredError => 'errors.sessionExpired'.tr();

  //-------------------------- LOGOUT ERROR --------------------------//
  static String get logoutFailedError => 'errors.logoutFailed'.tr();

  //-------------------------- SIDE-EFFECT ERROR --------------------------//
  static String get failedToEmitSideEffectError =>
      'errors.failedToEmitSideEffect'.tr();
}
