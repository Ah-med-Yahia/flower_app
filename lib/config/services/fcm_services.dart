import 'dart:developer';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flower_app/config/services/notifications_services.dart';
import 'package:flower_app/core/constants/app_routes_constant.dart';
import 'package:flower_app/core/constants/cache_constants.dart';
import 'package:flower_app/core/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

late AndroidNotificationChannel channel;
late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
bool isFlutterLocalNotificationsInitialized = false;

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await setupFlutterNotifications();
  final prefs = await SharedPreferences.getInstance();
  await prefs.reload();
  final currentCount = prefs.getInt(CacheConstants.notificationCount) ?? 0;
  await prefs.setInt(CacheConstants.notificationCount, currentCount + 1);
  await NotificationService().saveNotifications(message);

  if (message.notification == null) {
    showFlutterNotification(message);
  }
}

Future<void> setupFlutterNotifications() async {
  if (isFlutterLocalNotificationsInitialized) return;

  channel = const AndroidNotificationChannel(
    'high_importance_channel',
    'High Importance Notifications',
    description: 'This channel is used for important notifications.',
    importance: Importance.high,
  );

  flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  await flutterLocalNotificationsPlugin.initialize(
    settings: const InitializationSettings(
      android: AndroidInitializationSettings('launch_background'),
    ),
    onDidReceiveNotificationResponse: (NotificationResponse response) {
      FCMService().handleMessage();
    },
  );

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin
      >()
      ?.createNotificationChannel(channel);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  isFlutterLocalNotificationsInitialized = true;
}

void showFlutterNotification(RemoteMessage message) {
  final RemoteNotification? notification = message.notification;
  final AndroidNotification? android = message.notification?.android;

  if (notification != null && android != null) {
    flutterLocalNotificationsPlugin.show(
      id: notification.hashCode,
      title: notification.title,
      body: notification.body,
      notificationDetails: NotificationDetails(
        android: AndroidNotificationDetails(
          channel.id,
          channel.name,
          channelDescription: channel.description,
          icon: 'launch_background',
        ),
      ),
    );
  }
}

class FCMService {
  Future<void> getToken() async {
    final token = await FirebaseMessaging.instance.getToken();
    log('FCM Token: $token');
  }

  static RemoteMessage? initialNotificationMessage;

  Future<void> setupInteractedMessage() async {
    final RemoteMessage? initialMessage = await FirebaseMessaging.instance
        .getInitialMessage();
    if (initialMessage != null) {
      initialNotificationMessage = initialMessage;
      NotificationService().reset();
    }

    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      handleMessage();
    });
  }

  void handleMessage() {
    NotificationService().reset();
    final context = AppRouter.navigatorKey.currentContext;
    if (context != null) {
      context.pushNamed(AppRoutesConstants.notificationRoute);
    }
    log('User tapped notification');
  }
}
