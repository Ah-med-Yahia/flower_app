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
  void onRequest(
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
        // TODO(dev): Remove this log statement in production
        if (kDebugMode) {
          log('Failed to get auth token: ${error.message}', error: error);
        }
      },
    );

    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // Handle 401 unauthorized errors
    if (err.response?.statusCode == 401) {
      // Token might be expired, clear it from storage
      _clearExpiredToken();
      // TODO(dev): Hardcoded message for now
      _sessionManager.notifySessionExpired(
        message: 'Your session has expired. Please login again.',
      );
      // TODO(dev): Remove this log statement in production
      if (kDebugMode) {
        log('401 Unauthorized - Session expired');
      }
      // You can emit an event to logout the user or refresh token

      return handler.reject(
        DioException(
          requestOptions: err.requestOptions,
          error: 'Session expired',
          type: DioExceptionType.cancel,
        ),
      );
    }
    handler.next(err);
    super.onError(err, handler);
  }

  /// Clear expired token from storage using SecureStorageService methods
  Future<void> _clearExpiredToken() async {
    try {
      await _secureStorageService.clearAuthTokens();
      await _secureStorageService.writeBool(StorageKeys.isLoggedIn, false);
      // TODO(dev): Remove this log statement in production
      if (kDebugMode) {
        log('Auth tokens cleared due to session expiration');
      }
    } catch (e) {
      // TODO(dev): Remove this log statement in production
      if (kDebugMode) {
        log('Failed to clear expired token', error: e);
      }
    }
  }
}
