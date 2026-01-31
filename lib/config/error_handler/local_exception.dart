sealed class LocalException implements Exception {
  final String message;
  LocalException(this.message);
}

class CacheError extends LocalException {
  CacheError(super.message);
}
