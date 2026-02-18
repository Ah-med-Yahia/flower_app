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
      final msg = message ?? 'Session expired. Please login again.';
      _sessionExpiredController.add(msg);
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
