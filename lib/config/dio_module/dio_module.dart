import 'package:dio/dio.dart';
import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/config/cache_modules/secure_storage_module.dart';
import 'package:flower_app/core/constants/api_constants.dart';
import 'package:flower_app/core/constants/cache_constants.dart';
import 'package:injectable/injectable.dart';

@module
abstract class DioModule {
  @singleton
  Dio dio(SecureStorageService secureStorageService) {
    final dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        headers: {'Content-Type': 'application/json'},
      ),
    );

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final tokenResponse = await secureStorageService.read(
            StorageKeys.accessToken,
          );
          tokenResponse.map(
            success: (token) {
              if (token.data != null && token.data!.isNotEmpty) {
                options.headers['Authorization'] = 'Bearer ${token.data}';
              }
            },
            failure: (error) {
              // Token not found or error reading, continue without token
            },
          );
          return handler.next(options);
        },
        onError: (error, handler) async {
          // Handle 401 Unauthorized - token is invalid or expired
          if (error.response?.statusCode == 401) {
            // Clear the invalid token from secure storage
            await secureStorageService.clearAuthTokens();
            print('Invalid token detected. User needs to login again.');
          }
          return handler.next(error);
        },
      ),
    );

    return dio;
  }
}
