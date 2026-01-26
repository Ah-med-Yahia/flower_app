import 'dart:async';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

@singleton
class SessionManager {
  final _sessionExpiredController = StreamController<String>.broadcast();

  Stream<String> get sessionExpiredStream => _sessionExpiredController.stream;

  /// Emit session expired event
  void notifySessionExpired({String? message}) {
    if (!_sessionExpiredController.isClosed) {
      // TODO(dev): Hardcoded message for now
      final msg = message ?? 'Session expired. Please login again.';
      _sessionExpiredController.add(msg);
      // TODO(dev): Remove this log statement in production
      if (kDebugMode) {
        log('Session expired event emitted: $msg');
      }
    }
  }

  @disposeMethod
  void dispose() {
    _sessionExpiredController.close();
  }
}
