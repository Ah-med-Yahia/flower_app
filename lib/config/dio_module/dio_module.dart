import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../core/constants/api_constants.dart';
import 'auth_interceptor.dart';

@module
abstract class DioModule {
  @singleton
  Dio dio(AuthInterceptor authInterceptor) {
    final dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        sendTimeout: const Duration(seconds: 30),
      ),
    );

    // Add the auth interceptor to automatically handle token injection
    dio.interceptors.add(authInterceptor);
    // Add the PrettyDioLogger interceptor for logging requests and responses
    dio.interceptors.add(
      PrettyDioLogger(
        requestHeader: true,
        responseHeader: true,
        requestBody: true,
      ),
    );

    return dio;
  }
}
