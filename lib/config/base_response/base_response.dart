import 'package:freezed_annotation/freezed_annotation.dart';

import '../error_handler/error_handler.dart';

part 'base_response.freezed.dart';

@Freezed()
abstract class BaseResponse<T> with _$BaseResponse<T> {
  const factory BaseResponse.success(T data) = Success<T>;

  const factory BaseResponse.failure(ErrorHandler errorHandler) = Failure<T>;
}
