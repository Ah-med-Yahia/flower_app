import 'package:injectable/injectable.dart';

import '../../config/base_response/base_response.dart';
import '../../config/cache_modules/secure_storage_module.dart';
import '../constants/cache_constants.dart';

/// SRP violations [TokenService] Multiple responsibilities
/// Issues:
///        Manages token operations (get, save, clear)
///        Manages user data operations (getUserData, saveUserData)
///        Manages login state (isLoggedIn, saveLoginData)
///        Provides status reporting (getTokenStatus)

@injectable
class TokenService {
  final SecureStorageService _secureStorageService;

  TokenService(this._secureStorageService);

  /// Get the current authentication token using SecureStorageService extension
  Future<BaseResponse<String?>> getToken() async {
    return await _secureStorageService.getAuthTokens();
  }

  /// Save authentication token using SecureStorageService extension
  Future<BaseResponse<bool>> saveToken(String token) async {
    return await _secureStorageService.saveAuthTokens(accessToken: token);
  }

  /// Clear authentication token using SecureStorageService extension
  Future<BaseResponse<bool>> clearToken() async {
    return await _secureStorageService.clearAuthTokens();
  }

  /// Check if user is currently logged in
  Future<BaseResponse<bool>> isLoggedIn() async {
    final tokenResponse = await _secureStorageService.getAuthTokens();
    final isLoggedInResponse = await _secureStorageService.readBool(
      StorageKeys.isLoggedIn,
    );

    return tokenResponse.when(
      success: (token) {
        return isLoggedInResponse.when(
          success: (isLoggedIn) {
            final hasValidToken = token != null && token.isNotEmpty;
            final isUserLoggedIn = isLoggedIn == true;
            return BaseResponse.success(hasValidToken && isUserLoggedIn);
          },
          failure: (error) => BaseResponse.failure(error),
        );
      },
      failure: (error) => BaseResponse.failure(error),
    );
  }

  /// Get stored user data
  Future<BaseResponse<Map<String, dynamic>?>> getUserData() async {
    return await _secureStorageService.readJson(StorageKeys.userModel);
  }

  /// Save user data to storage
  Future<BaseResponse<bool>> saveUserData(Map<String, dynamic> userData) async {
    return await _secureStorageService.writeJson(
      StorageKeys.userModel,
      userData,
    );
  }

  /// Clear all authentication data (logout) - uses SecureStorageService methods
  Future<BaseResponse<bool>> clearAuthData() async {
    final results = await Future.wait([
      _secureStorageService.clearAuthTokens(), // Use extension method
      _secureStorageService.writeBool(StorageKeys.isLoggedIn, false),
      _secureStorageService.delete(StorageKeys.userModel),
    ]);

    for (final result in results) {
      final failure = result.when(success: (_) => null, failure: (f) => f);
      if (failure != null) {
        return BaseResponse.failure(failure);
      }
    }

    return const BaseResponse.success(true);
  }

  /// Save complete login data (token + user data + login status)
  /// This is the main method to use after successful login
  Future<BaseResponse<bool>> saveLoginData({
    required String token,
    required Map<String, dynamic> userData,
  }) async {
    final results = await Future.wait([
      _secureStorageService.saveAuthTokens(accessToken: token),
      // Use extension method
      _secureStorageService.writeBool(StorageKeys.isLoggedIn, true),
      _secureStorageService.writeJson(StorageKeys.userModel, userData),
    ]);

    for (final result in results) {
      final failure = result.when(success: (_) => null, failure: (f) => f);
      if (failure != null) {
        return BaseResponse.failure(failure);
      }
    }

    return const BaseResponse.success(true);
  }

  /// Check if token is valid (exists and not empty)
  Future<BaseResponse<bool>> isTokenValid() async {
    final tokenResponse = await getToken(); // Uses extension method internally

    return tokenResponse.when(
      success: (token) {
        if (token == null || token.isEmpty) {
          return const BaseResponse.success(false);
        }

        // You can add JWT token expiration checking here
        // For now, just check if token exists
        return const BaseResponse.success(true);
      },
      failure: (error) => const BaseResponse.success(false),
    );
  }

  /// Check token status and return detailed information
  Future<Map<String, dynamic>> getTokenStatus() async {
    final tokenResponse = await getToken();
    final isLoggedInResponse = await isLoggedIn();
    final isValidResponse = await isTokenValid();

    return {
      'hasToken': tokenResponse.when(
        success: (token) => token != null && token.isNotEmpty,
        failure: (_) => false,
      ),
      'isLoggedIn': isLoggedInResponse.when(
        success: (loggedIn) => loggedIn,
        failure: (_) => false,
      ),
      'isValid': isValidResponse.when(
        success: (valid) => valid,
        failure: (_) => false,
      ),
      'token': tokenResponse.when(
        success: (token) => token,
        failure: (_) => null,
      ),
    };
  }
}
