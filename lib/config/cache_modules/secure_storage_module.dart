import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import 'dart:convert';

@lazySingleton
class SecureStorageService {
  late final FlutterSecureStorage _storage;

  SecureStorageService() {
    _storage = FlutterSecureStorage(
      aOptions: _defaultAndroidOptions(),
      iOptions: _defaultIOSOptions(),
    );
  }

  AndroidOptions _defaultAndroidOptions() => const AndroidOptions(
    keyCipherAlgorithm: KeyCipherAlgorithm.RSA_ECB_PKCS1Padding,
    storageCipherAlgorithm: StorageCipherAlgorithm.AES_GCM_NoPadding,
  );

  IOSOptions _defaultIOSOptions() =>
      const IOSOptions(accessibility: KeychainAccessibility.first_unlock);

  Future<bool> write(String key, String value) async {
    try {
      await _storage.write(key: key, value: value);
      return true;
    } catch (e) {
      _handleError('write', e);
      return false;
    }
  }

  Future<String?> read(String key) async {
    try {
      return await _storage.read(key: key);
    } catch (e) {
      _handleError('read', e);
      return null;
    }
  }

  Future<bool> delete(String key) async {
    try {
      await _storage.delete(key: key);
      return true;
    } catch (e) {
      _handleError('delete', e);
      return false;
    }
  }

  Future<bool> deleteAll() async {
    try {
      await _storage.deleteAll();
      return true;
    } catch (e) {
      _handleError('deleteAll', e);
      return false;
    }
  }

  Future<bool> containsKey(String key) async {
    try {
      return await _storage.containsKey(key: key);
    } catch (e) {
      _handleError('containsKey', e);
      return false;
    }
  }

  Future<List<String>> getAllKeys() async {
    try {
      final allData = await _storage.readAll();
      return allData.keys.toList();
    } catch (e) {
      _handleError('getAllKeys', e);
      return [];
    }
  }

  Future<bool> writeJson(String key, Map<String, dynamic> value) async {
    try {
      final jsonString = jsonEncode(value);
      return await write(key, jsonString);
    } catch (e) {
      _handleError('writeJson', e);
      return false;
    }
  }

  Future<Map<String, dynamic>?> readJson(String key) async {
    try {
      final jsonString = await read(key);
      if (jsonString == null) return null;
      return jsonDecode(jsonString) as Map<String, dynamic>;
    } catch (e) {
      _handleError('readJson', e);
      return null;
    }
  }

  Future<bool> writeList(String key, List<String> value) async {
    try {
      final jsonString = jsonEncode(value);
      return await write(key, jsonString);
    } catch (e) {
      _handleError('writeList', e);
      return false;
    }
  }

  Future<List<String>?> readList(String key) async {
    try {
      final jsonString = await read(key);
      if (jsonString == null) return null;
      final decoded = jsonDecode(jsonString);
      return List<String>.from(decoded);
    } catch (e) {
      _handleError('readList', e);
      return null;
    }
  }

  Future<bool> writeBool(String key, bool value) async {
    return await write(key, value.toString());
  }

  Future<bool?> readBool(String key) async {
    final value = await read(key);
    if (value == null) return null;
    return value.toLowerCase() == 'true';
  }

  Future<bool> writeInt(String key, int value) async {
    return await write(key, value.toString());
  }

  Future<int?> readInt(String key) async {
    final value = await read(key);
    if (value == null) return null;
    return int.tryParse(value);
  }

  Future<bool> writeDouble(String key, double value) async {
    return await write(key, value.toString());
  }

  Future<double?> readDouble(String key) async {
    final value = await read(key);
    if (value == null) return null;
    return double.tryParse(value);
  }

  void _handleError(String method, dynamic error) {
    print('SecureStorageService.$method error: $error');
  }
}

class StorageKeys {
  static const String accessToken = 'access_token';
  static const String refreshToken = 'refresh_token';
  static const String userId = 'user_id';
  static const String userEmail = 'user_email';
  static const String isLoggedIn = 'is_logged_in';
  static const String userName = 'user_name';
  static const String deviceId = 'device_id';
  static const String fcmToken = 'fcm_token';
  static const String theme = 'theme';
  static const String language = 'language';

  StorageKeys._();
}

extension SecureStorageExtension on SecureStorageService {
  Future<bool> saveAuthTokens({
    required String accessToken,
    String? refreshToken,
  }) async {
    final results = await Future.wait([
      write(StorageKeys.accessToken, accessToken),
      if (refreshToken != null) write(StorageKeys.refreshToken, refreshToken),
    ]);
    return results.every((r) => r);
  }

  Future<Map<String, String?>> getAuthTokens() async {
    final results = await Future.wait([
      read(StorageKeys.accessToken),
      read(StorageKeys.refreshToken),
    ]);
    return {'accessToken': results[0], 'refreshToken': results[1]};
  }

  Future<bool> clearAuthTokens() async {
    final results = await Future.wait([
      delete(StorageKeys.accessToken),
      delete(StorageKeys.refreshToken),
      delete(StorageKeys.isLoggedIn),
    ]);
    return results.every((r) => r);
  }
}
