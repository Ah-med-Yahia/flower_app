import 'dart:developer';

import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/config/error_handler/error_handler.dart';

Future<BaseResponse<T>> safeApiCall<T>(Future<T> Function() apiCall) async {
  try {
    final response = await apiCall();
    return BaseResponse<T>.success(response);
  } catch (error) {
    log(error.toString());
    return BaseResponse<T>.failure(ErrorHandler.handle(error));
  }
}
