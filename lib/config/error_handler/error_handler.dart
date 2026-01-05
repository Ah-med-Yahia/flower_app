import 'package:dio/dio.dart';
import 'package:flower_app/config/error_handler/error_model.dart';
import 'package:flower_app/config/error_handler/local_exception.dart';
import 'package:flower_app/core/constants/errors_constants.dart';

enum DataSource {
  noContent,
  badRequest,
  forbidden,
  unauthorized,
  notFound,
  internalServerError,
  connectTimeout,
  cancel,
  receiveTimeout,
  sendTimeout,
  cacheError,
  noInternetConnection,
  badCertificate,
  unknown,
}

abstract class ResponseCode {
  static const int success = 200;
  static const int created = 201;
  static const int noContent = 204;
  static const int badRequest = 400;
  static const int unauthorized = 401;
  static const int forbidden = 403;
  static const int notFound = 404;
  static const int unprocessableEntity = 422;
  static const int internalServerError = 500;
  static const int connectTimeout = -1;
  static const int cancel = -2;
  static const int receiveTimeout = -3;
  static const int sendTimeout = -4;
  static const int cacheError = -5;
  static const int noInternetConnection = -6;
  static const int badCertificate = -7;
  static const int unknown = -8;
}

extension DataSourceExtension on DataSource {
  ErrorModel toFailure() {
    return switch (this) {
      DataSource.noContent => ErrorModel(
        code: ResponseCode.noContent,
        message: ErrorsConstant.noContent,
      ),
      DataSource.badRequest => ErrorModel(
        code: ResponseCode.badRequest,
        message: ErrorsConstant.badRequestError,
      ),
      DataSource.forbidden => ErrorModel(
        code: ResponseCode.forbidden,
        message: ErrorsConstant.forbiddenError,
      ),
      DataSource.unauthorized => ErrorModel(
        code: ResponseCode.unauthorized,
        message: ErrorsConstant.unauthorizedError,
      ),
      DataSource.notFound => ErrorModel(
        code: ResponseCode.notFound,
        message: ErrorsConstant.notFoundError,
      ),
      DataSource.internalServerError => ErrorModel(
        code: ResponseCode.internalServerError,
        message: ErrorsConstant.internalServerError,
      ),
      DataSource.connectTimeout => ErrorModel(
        code: ResponseCode.connectTimeout,
        message: ErrorsConstant.timeoutError,
      ),
      DataSource.cancel => ErrorModel(
        code: ResponseCode.cancel,
        message: ErrorsConstant.defaultError,
      ),
      DataSource.receiveTimeout => ErrorModel(
        code: ResponseCode.receiveTimeout,
        message: ErrorsConstant.timeoutError,
      ),
      DataSource.sendTimeout => ErrorModel(
        code: ResponseCode.sendTimeout,
        message: ErrorsConstant.timeoutError,
      ),
      DataSource.cacheError => ErrorModel(
        code: ResponseCode.cacheError,
        message: ErrorsConstant.cacheError,
      ),
      DataSource.noInternetConnection => ErrorModel(
        code: ResponseCode.noInternetConnection,
        message: ErrorsConstant.noInternetError,
      ),
      DataSource.badCertificate => ErrorModel(
        code: ResponseCode.badCertificate,
        message: ErrorsConstant.defaultError,
      ),
      DataSource.unknown => ErrorModel(
        code: ResponseCode.unknown,
        message: ErrorsConstant.defaultError,
      ),
    };
  }
}

class ErrorHandler implements Exception {
  final ErrorModel errorModel;

  ErrorHandler._({required this.errorModel});

  factory ErrorHandler.handle(Object error) {
    if (error is DioException) {
      return ErrorHandler._(errorModel: _handleDioError(error));
    } else if (error is LocalException) {
      return ErrorHandler._(errorModel: _handleLocalException(error));
    } else {
      return ErrorHandler._(errorModel: DataSource.unknown.toFailure());
    }
  }

  String? get message => errorModel.message;

  int? get code => errorModel.code;

  @override
  String toString() =>
      'ErrorHandler: ${errorModel.message} (Code: ${errorModel.code})';
}

ErrorModel _handleDioError(DioException error) {
  return switch (error.type) {
    DioExceptionType.connectionTimeout => DataSource.connectTimeout.toFailure(),
    DioExceptionType.sendTimeout => DataSource.sendTimeout.toFailure(),
    DioExceptionType.receiveTimeout => DataSource.receiveTimeout.toFailure(),
    DioExceptionType.badResponse => _handleBadResponse(error),
    DioExceptionType.connectionError =>
      DataSource.noInternetConnection.toFailure(),
    DioExceptionType.cancel => DataSource.cancel.toFailure(),
    DioExceptionType.badCertificate => DataSource.badCertificate.toFailure(),
    DioExceptionType.unknown => _handleUnknownError(error),
  };
}

ErrorModel _handleBadResponse(DioException error) {
  final response = error.response;
  if (response == null) {
    return DataSource.unknown.toFailure();
  }

  try {
    return ErrorModel.fromResponse(
      json: response.data,
      statusCode: response.statusCode,
    );
  } catch (_) {
    return _mapStatusCodeToDataSource(response.statusCode).toFailure();
  }
}

DataSource _mapStatusCodeToDataSource(int? statusCode) {
  if (statusCode == null) return DataSource.unknown;

  return switch (statusCode) {
    400 => DataSource.badRequest,
    401 => DataSource.unauthorized,
    403 => DataSource.forbidden,
    404 => DataSource.notFound,
    int code when code >= 500 && code < 600 => DataSource.internalServerError,
    _ => DataSource.unknown,
  };
}

ErrorModel _handleUnknownError(DioException error) {
  if (error.message?.toLowerCase().contains('socket') ?? false) {
    return DataSource.noInternetConnection.toFailure();
  }
  return DataSource.unknown.toFailure();
}

ErrorModel _handleLocalException(LocalException error) {
  return switch (error.type) {
    CacheError() => DataSource.cacheError.toFailure(),
  };
}
