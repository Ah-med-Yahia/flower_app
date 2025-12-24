import 'package:injectable/injectable.dart';
import 'package:dio/dio.dart';
import 'package:flower_app/core/constants/api_constants.dart';
import 'package:flower_app/core/constants/cache_constants.dart';

@module
abstract class DioModule {
  @singleton
  Dio get dio => Dio(
    BaseOptions(
      baseUrl: ApiConstants.baseUrl,
      headers: {CacheConstants.token: ''},
    ),
  );
}
