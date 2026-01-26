import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

@singleton
class LoggerInterceptor extends PrettyDioLogger {
  LoggerInterceptor()
    : super(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        error: true,
        compact: false,
        logPrint: (object) {
          // Redact Authorization header values from logs
          _logAuthHeader(object);
        },
      );

  static void _logAuthHeader(Object object) {
    final log = object.toString();
    if (log.contains('Authorization')) {
      debugPrint(
        log.replaceAll(
          RegExp(r'(Authorization:\s*)(Bearer\s+)?\S+'),
          r'$1[REDACTED]',
        ),
      );
    } else {
      debugPrint(log);
    }
  }
}
