import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

import '../../core/constants/cache_constants.dart';
import '../../core/services/session_manager.dart';
import '../base_response/base_response.dart';
import '../cache_modules/secure_storage_module.dart';

@injectable
class AuthInterceptor extends Interceptor {
  final SecureStorageService _secureStorageService;
  final SessionManager _sessionManager;

  AuthInterceptor(this._secureStorageService, this._sessionManager);

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // Use the SecureStorageService extension method directly
    final tokenResponse = await _secureStorageService.getAuthTokens();

    tokenResponse.when(
      success: (token) {
        if (token != null && token.isNotEmpty) {
          // Add the token to the Authorization header
          options.headers['Authorization'] = 'Bearer $token';
          // Also add to the TOKEN header if your API expects it
          options.headers[CacheConstants.token] = token;
        }
      },
      failure: (error) {
        if (kDebugMode) {
        }
      },
    );

    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response?.statusCode == 401) {
     _clearExpiredToken();
      _sessionManager.notifySessionExpired(
        message: 'Your session has expired. Please login again.',
      );
      if (kDebugMode) {
        log('401 Unauthorized - Session expired');
      }

      return handler.reject(
        DioException(
          requestOptions: err.requestOptions,
          error: 'Session expired',
          type: DioExceptionType.cancel,
        ),
      );
    }
    handler.next(err);
  }

  /// Clear expired token from storage using SecureStorageService methods
  Future<void> _clearExpiredToken() async {
    try {
      await _secureStorageService.clearAuthTokens();
      await _secureStorageService.writeBool(StorageKeys.isLoggedIn, false);
      
      if (kDebugMode) {
        log('Auth tokens cleared due to session expiration');
      }
    } catch (e) {
      if (kDebugMode) {
        log('Failed to clear expired token', error: e);
      }
    }
  }
}
