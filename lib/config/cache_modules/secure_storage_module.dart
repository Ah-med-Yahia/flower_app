import 'dart:convert';

import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/config/error_handler/error_handler.dart';
import 'package:flower_app/config/error_handler/local_exception.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';

import '../../core/constants/cache_constants.dart';

/// [SecureStorageService] Too Many Type Handlers
/// Issues:
///       Handles too many data types (String, JSON, List, Bool, Int, Double)
/// Recommendation:
/// Consider using a generic approach or creating specialized storage services for different data types.

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

  Future<BaseResponse<bool>> write(String key, String value) async {
    try {
      await _storage.write(key: key, value: value);
      return const BaseResponse<bool>.success(true);
    } catch (e) {
      return BaseResponse<bool>.failure(_handleError(StorageMethods.write, e));
    }
  }

  Future<BaseResponse<String?>> read(String key) async {
    try {
      final result = await _storage.read(key: key);
      return BaseResponse<String?>.success(result);
    } catch (e) {
      return BaseResponse<String?>.failure(
        _handleError(StorageMethods.read, e),
      );
    }
  }

  Future<BaseResponse<bool>> delete(String key) async {
    try {
      await _storage.delete(key: key);
      return const BaseResponse<bool>.success(true);
    } catch (e) {
      return BaseResponse<bool>.failure(_handleError(StorageMethods.delete, e));
    }
  }

  Future<BaseResponse<bool>> deleteAll() async {
    try {
      await _storage.deleteAll();
      return const BaseResponse<bool>.success(true);
    } catch (e) {
      return BaseResponse<bool>.failure(
        _handleError(StorageMethods.deleteAll, e),
      );
    }
  }

  Future<BaseResponse<bool>> containsKey(String key) async {
    try {
      final result = await _storage.containsKey(key: key);
      return BaseResponse<bool>.success(result);
    } catch (e) {
      return BaseResponse<bool>.failure(
        _handleError(StorageMethods.containsKey, e),
      );
    }
  }

  Future<BaseResponse<List<String>>> getAllKeys() async {
    try {
      final allData = await _storage.readAll();
      return BaseResponse<List<String>>.success(allData.keys.toList());
    } catch (e) {
      return BaseResponse<List<String>>.failure(
        _handleError(StorageMethods.getAllKeys, e),
      );
    }
  }

  Future<BaseResponse<bool>> writeJson(
    String key,
    Map<String, dynamic> value,
  ) async {
    try {
      final jsonString = jsonEncode(value);
      final result = await write(key, jsonString);
      return result;
    } catch (e) {
      return BaseResponse<bool>.failure(
        _handleError(StorageMethods.writeJson, e),
      );
    }
  }

  Future<BaseResponse<Map<String, dynamic>?>> readJson(String key) async {
    try {
      final response = await read(key);

      return response.when(
        success: (s) {
          if (s == null) {
            return const BaseResponse<Map<String, dynamic>?>.success(null);
          }

          return BaseResponse<Map<String, dynamic>?>.success(
            jsonDecode(s) as Map<String, dynamic>,
          );
        },
        failure: (f) {
          return BaseResponse<Map<String, dynamic>?>.failure(f);
        },
      );
    } catch (e) {
      return BaseResponse<Map<String, dynamic>?>.failure(
        _handleError(StorageMethods.readJson, e),
      );
    }
  }

  Future<BaseResponse<bool>> writeList(String key, List<String> value) async {
    try {
      final jsonString = jsonEncode(value);
      final result = await write(key, jsonString);
      return result;
    } catch (e) {
      return BaseResponse<bool>.failure(
        _handleError(StorageMethods.writeList, e),
      );
    }
  }

  Future<BaseResponse<List<String>?>> readList(String key) async {
    try {
      final response = await read(key);

      return response.when(
        success: (s) {
          if (s == null) {
            return const BaseResponse<List<String>?>.success(null);
          }

          final decoded = jsonDecode(s);
          final list = List<String>.from(decoded);

          return BaseResponse<List<String>?>.success(list);
        },
        failure: (f) {
          return BaseResponse<List<String>?>.failure(f);
        },
      );
    } catch (e) {
      return BaseResponse<List<String>?>.failure(
        _handleError(StorageMethods.readList, e),
      );
    }
  }

  Future<BaseResponse<bool>> writeBool(String key, bool value) async {
    try {
      final result = await write(key, value.toString());
      return result;
    } catch (e) {
      return BaseResponse<bool>.failure(
        _handleError(StorageMethods.writeBool, e),
      );
    }
  }

  Future<BaseResponse<bool?>> readBool(String key) async {
    try {
      final response = await read(key);

      return response.when(
        success: (s) {
          if (s == null) {
            return const BaseResponse<bool?>.success(null);
          }

          return BaseResponse<bool?>.success(s.toLowerCase() == 'true');
        },
        failure: (f) {
          return BaseResponse<bool?>.failure(f);
        },
      );
    } catch (e) {
      return BaseResponse<bool?>.failure(
        _handleError(StorageMethods.readBool, e),
      );
    }
  }

  Future<BaseResponse<bool>> writeInt(String key, int value) async {
    try {
      final result = await write(key, value.toString());
      return result;
    } catch (e) {
      return BaseResponse<bool>.failure(
        _handleError(StorageMethods.writeInt, e),
      );
    }
  }

  Future<BaseResponse<int?>> readInt(String key) async {
    try {
      final response = await read(key);

      return response.when(
        success: (s) {
          if (s == null) {
            return const BaseResponse<int?>.success(null);
          }

          return BaseResponse<int?>.success(int.tryParse(s));
        },
        failure: (f) {
          return BaseResponse<int?>.failure(f);
        },
      );
    } catch (e) {
      return BaseResponse<int?>.failure(
        _handleError(StorageMethods.readInt, e),
      );
    }
  }

  Future<BaseResponse<bool>> writeDouble(String key, double value) async {
    try {
      final result = await write(key, value.toString());
      return result;
    } catch (e) {
      return BaseResponse<bool>.failure(
        _handleError(StorageMethods.writeDouble, e),
      );
    }
  }

  Future<BaseResponse<double?>> readDouble(String key) async {
    try {
      final resultResponse = await read(key);
      return resultResponse.when(
        success: (s) {
          if (s == null) {
            return const BaseResponse<double?>.success(null);
          }
          return BaseResponse<double?>.success(double.tryParse(s));
        },
        failure: (f) {
          return BaseResponse<double?>.failure(f);
        },
      );
    } catch (e) {
      return BaseResponse<double?>.failure(
        _handleError(StorageMethods.readDouble, e),
      );
    }
  }

  ErrorHandler _handleError(String method, dynamic error) {
    return ErrorHandler.handle(
      CacheError('SecureStorageService.$method error: $error'),
    );
  }
}

extension SecureStorageExtension on SecureStorageService {
  Future<BaseResponse<bool>> saveAuthTokens({
    required String accessToken,
  }) async {
    final result = await write(StorageKeys.accessToken, accessToken);
    return result.when(
      success: (s) => const BaseResponse<bool>.success(true),
      failure: (f) => BaseResponse<bool>.failure(f),
    );
  }

  Future<BaseResponse<String?>> getAuthTokens() async {
    final result = await read(StorageKeys.accessToken);
    return result.when(
      success: (s) => BaseResponse.success(s),
      failure: (f) => BaseResponse.failure(f),
    );
  }

  Future<BaseResponse<bool>> clearAuthTokens() async {
    final results = await delete(StorageKeys.accessToken);
    return results.when(
      success: (s) => BaseResponse.success(s),
      failure: (f) => BaseResponse.failure(f),
    );
  }
}
