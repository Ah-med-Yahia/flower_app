sealed class LocalException implements Exception {
  final LocalException type;
  LocalException({required this.type});
}

class CacheError extends LocalException {
  CacheError() : super(type: CacheError());
}





