class CacheConstants {
  CacheConstants._();

  static const String token = 'TOKEN';
  static const String errorMessageKey = 'message';
  static const String notificationCount = 'notification_count';
}

class StorageKeys {
  static const String accessToken = 'access_token';
  static const String isLoggedIn = 'is_logged_in';
  static const String deviceId = 'device_id';
  static const String saveAuthTokens = 'saveAuthTokens';
  static const String getAuthTokens = 'getAuthTokens';
  static const String userModel = 'userModel';
  StorageKeys._();
}

class StorageMethods {
  static const String read = 'read';
  static const String write = 'write';
  static const String delete = 'delete';
  static const String deleteAll = 'deleteAll';
  static const String containsKey = 'containsKey';
  static const String getAllKeys = 'getAllKeys';
  static const String writeJson = 'writeJson';
  static const String readJson = 'readJson';
  static const String writeList = 'writeList';
  static const String readList = 'readList';
  static const String writeBool = 'writeBool';
  static const String readBool = 'readBool';
  static const String writeInt = 'writeInt';
  static const String readInt = 'readInt';
  static const String writeDouble = 'writeDouble';
  static const String readDouble = 'readDouble';
}
