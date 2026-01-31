class ErrorsConstant {
  ErrorsConstant._();

  // TODO(Salah): Handle Localization
  static const String badRequestError = 'Invalid request.';
  static const String noContent = 'No content available.';
  static const String forbiddenError = 'Access forbidden.';
  static const String unauthorizedError = 'Unauthorized access.';
  static const String notFoundError = 'Resource not found.';
  static const String conflictError = 'Request conflict.';
  static const String internalServerError = 'Internal server error.';
  static const String unknownError = 'An unknown error occurred.';
  static const String timeoutError = 'Connection timeout. Please try again.';
  static const String defaultError = 'Something went wrong. Please try again.';
  static const String noInternetError =
      'No internet connection. Please check your network.';
  static const String loadingMessage = 'Loading...';
  static const String retryAgainMessage = 'Please try again.';
  static const String ok = 'OK';

  //-------------------------- AUTH ERROR --------------------------//
  static const String authenticationCheckError = 'Authentication check failed:';

  //-------------------------- CACHE ERROR --------------------------//
  static const String cacheError = 'Cache error occurred.';
  static const String noCacheDataAvailableError = 'No cached data available';
  static const String failedToLoadCachedDataError =
      'Failed to load cached data:';

  //-------------------------- SESSION ERROR --------------------------//
  static const String userNotLoggedInError = 'User not logged in';
  static const String sessionExpiredError = 'Session expired';

  //-------------------------- LOGOUT ERROR --------------------------//
  static const String logoutFailedError = 'Logout failed:';

  //-------------------------- SIDE-EFFECT ERROR --------------------------//
  static const String failedToEmitSideEffectError =
      'Failed to emit side effect';
}
