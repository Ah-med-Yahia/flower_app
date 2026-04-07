import 'dart:async';
import 'package:flower_app/core/constants/cache_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();


  final StreamController<int> _countController = StreamController<int>.broadcast();
  Stream<int> get countStream => _countController.stream;

  int _count = 0;
  int get count => _count;


  Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();
    _count = prefs.getInt(CacheConstants.notificationCount) ?? 0;
    _countController.add(_count);
  }

  Future<void> increment() async {
    _count++;
    _countController.add(_count);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(CacheConstants.notificationCount, _count);
  }

  Future<void> reset() async {
    _count = 0;
    _countController.add(_count);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(CacheConstants.notificationCount, 0);
  }
}