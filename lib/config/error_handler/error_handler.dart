import 'package:dio/dio.dart';
import 'package:flower_app/config/error_handler/api_error_model.dart';
import 'package:flower_app/core/constants/api_errors_constants.dart';

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
  ApiErrorModel toFailure() {
    return switch (this) {
      DataSource.noContent =>
          _createError(ResponseCode.noContent, ApiErrors.noContent),
      DataSource.badRequest =>
          _createError(ResponseCode.badRequest, ApiErrors.badRequestError),
      DataSource.forbidden =>
          _createError(ResponseCode.forbidden, ApiErrors.forbiddenError),
      DataSource.unauthorized =>
          _createError(ResponseCode.unauthorized, ApiErrors.unauthorizedError),
      DataSource.notFound =>
          _createError(ResponseCode.notFound, ApiErrors.notFoundError),
      DataSource.internalServerError =>
          _createError(
              ResponseCode.internalServerError, ApiErrors.internalServerError),
      DataSource.connectTimeout =>
          _createError(ResponseCode.connectTimeout, ApiErrors.timeoutError),
      DataSource.cancel =>
          _createError(ResponseCode.cancel, ApiErrors.defaultError),
      DataSource.receiveTimeout =>
          _createError(ResponseCode.receiveTimeout, ApiErrors.timeoutError),
      DataSource.sendTimeout =>
          _createError(ResponseCode.sendTimeout, ApiErrors.timeoutError),
      DataSource.cacheError =>
          _createError(ResponseCode.cacheError, ApiErrors.cacheError),
      DataSource.noInternetConnection =>
          _createError(
              ResponseCode.noInternetConnection, ApiErrors.noInternetError),
      DataSource.badCertificate =>
          _createError(ResponseCode.badCertificate, ApiErrors.defaultError),
      DataSource.unknown =>
          _createError(ResponseCode.unknown, ApiErrors.defaultError),
    };
  }

  ApiErrorModel _createError(int code, String message) {
    return ApiErrorModel(code: code, message: message);
  }
}

class ErrorHandler implements Exception {
  final ApiErrorModel apiErrorModel;

  ErrorHandler._({required this.apiErrorModel});

  factory ErrorHandler.handle(Object error) {
    if (error is DioException) {
      return ErrorHandler._(apiErrorModel: _handleDioError(error));
    } else if (error is ApiErrorModel) {
      return ErrorHandler._(apiErrorModel: error);
    } else {
      return ErrorHandler._(apiErrorModel: DataSource.unknown.toFailure());
    }
  }

  String? get message => apiErrorModel.message;

  int? get code => apiErrorModel.code;

  @override
  String toString() =>
      'ErrorHandler: ${apiErrorModel.message} (Code: ${apiErrorModel.code})';
}

ApiErrorModel _handleDioError(DioException error) {
  return switch (error.type) {
    DioExceptionType.connectionTimeout => DataSource.connectTimeout.toFailure(),
    DioExceptionType.sendTimeout => DataSource.sendTimeout.toFailure(),
    DioExceptionType.receiveTimeout => DataSource.receiveTimeout.toFailure(),
    DioExceptionType.badResponse => _handleBadResponse(error),
    DioExceptionType.connectionError => _handleConnectionError(error),
    DioExceptionType.cancel => DataSource.cancel.toFailure(),
    DioExceptionType.badCertificate => DataSource.badCertificate.toFailure(),
    DioExceptionType.unknown => _handleUnknownError(error),
  };
}

ApiErrorModel _handleBadResponse(DioException error) {
  final response = error.response;
  if (response == null) {
    return DataSource.unknown.toFailure();
  }

  try {
    return ApiErrorModel.fromJson(response.data);
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

ApiErrorModel _handleConnectionError(DioException error) {
  if (error.message?.toLowerCase().contains('socket') ?? false) {
    return DataSource.noInternetConnection.toFailure();
  }
  return DataSource.noInternetConnection.toFailure();
}

ApiErrorModel _handleUnknownError(DioException error) {
  if (error.message?.toLowerCase().contains('socket') ?? false) {
    return DataSource.noInternetConnection.toFailure();
  }
  return DataSource.unknown.toFailure();
}
