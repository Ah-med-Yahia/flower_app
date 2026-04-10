import 'package:flower_app/features/tabs/profile/profile_main/presentation/models_ui/notification.dart';

class NotificationsState {
  final List<AppNotification>? notifications;
  final bool isEmpty;
  NotificationsState({this.notifications, this.isEmpty = false});

  NotificationsState copyWith({
    List<AppNotification>? notifications,
    bool? isEmpty,
  }) {
    return NotificationsState(
      notifications: notifications ?? this.notifications,
      isEmpty: isEmpty ?? this.isEmpty,
    );
  }
}
