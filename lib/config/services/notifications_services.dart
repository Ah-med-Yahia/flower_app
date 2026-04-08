import 'dart:async';
import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flower_app/core/constants/cache_constants.dart';
import 'package:flower_app/features/tabs/profile/profile_main/presentation/models_ui/notification.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();

  final StreamController<int> _countController =
      StreamController<int>.broadcast();
  Stream<int> get countStream => _countController.stream;

  int _count = 0;
  int get count => _count;

  Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();
    _count = prefs.getInt(CacheConstants.notificationCount) ?? 0;
    _countController.add(_count);
  }

  Future<void> saveNotifications(RemoteMessage message) async {
    final prefs = await SharedPreferences.getInstance();
    final oldData = prefs.getStringList(CacheConstants.notifications) ?? [];

    final oldNotifications = oldData
        .map((e) => AppNotification.fromJson(jsonDecode(e)))
        .toList();

    final newNotification = AppNotification(
      id: message.messageId ?? DateTime.now().millisecondsSinceEpoch.toString(),
      title: message.notification?.title,
      body: message.notification?.body,
      time: DateTime.now().toIso8601String(),
      isSeen: false,
    );

    final alreadyExists = oldNotifications.any(
      (n) => n.id == newNotification.id,
    );

    if (!alreadyExists) {
      oldNotifications.insert(0, newNotification);
    }

    await prefs.setStringList(
      CacheConstants.notifications,
      oldNotifications.map((e) => jsonEncode(e.toJson())).toList(),
    );
  }

  Future<void> markAllAsSeen() async {
    final prefs = await SharedPreferences.getInstance();

    final data = prefs.getStringList(CacheConstants.notifications) ?? [];

    final updated = data.map((e) {
      final notif = AppNotification.fromJson(jsonDecode(e));

      return jsonEncode(notif.copyWith(isSeen: true).toJson());
    }).toList();

    await prefs.setStringList(CacheConstants.notifications, updated);
  }

  Future<List<AppNotification>> getNotifications() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getStringList(CacheConstants.notifications) ?? [];
    return data.map((e) => AppNotification.fromJson(jsonDecode(e))).toList();
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
