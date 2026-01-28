import '../base_response/base_response.dart';
import '../error_handler/error_handler.dart';

Future<BaseResponse<T>> safeApiCall<T>(Future<T> Function() apiCall) async {
  try {
    final response = await apiCall();
    return BaseResponse<T>.success(response);
  } catch (error) {
    return BaseResponse<T>.failure(ErrorHandler.handle(error));
  }
}
