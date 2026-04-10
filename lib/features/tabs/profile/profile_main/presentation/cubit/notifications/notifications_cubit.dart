import 'dart:async';
import 'package:flower_app/config/services/notifications_services.dart';
import 'package:flower_app/features/tabs/profile/profile_main/presentation/cubit/notifications/notifications_intents.dart';
import 'package:flower_app/features/tabs/profile/profile_main/presentation/cubit/notifications/notifications_side_effect.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flower_app/features/tabs/profile/profile_main/presentation/cubit/notifications/notifications_state.dart';
import 'package:injectable/injectable.dart';

@injectable
class NotificationsCubit extends Cubit<NotificationsState> {
  NotificationsCubit() : super(NotificationsState());

  final StreamController<NotificationsSideEffect> _sideEffectController =
      StreamController<NotificationsSideEffect>.broadcast();
  Stream<NotificationsSideEffect> get sideEffectStream =>
      _sideEffectController.stream;

  void doIntent(NotificationsIntent intent) {
    switch (intent) {
      case GetNotificationsIntent():
        _getNotifications();
      case MarkAllAsSeenIntent():
        _markAllAsSeen();
    }
  }

  Future<void> _getNotifications() async {
    _sideEffectController.add(LoadNotifications());
    final notifications = await NotificationService().getNotifications();
    _sideEffectController.add(HideLoading());
    _sideEffectController.add(MarkAllAsSeen());
    if (notifications.isEmpty) {
      emit(state.copyWith(isEmpty: true));
    } else {
      emit(state.copyWith(notifications: notifications));
    }
  }

  Future<void> _markAllAsSeen() async {
    await NotificationService().markAllAsSeen();
  }

  @override
  Future<void> close() {
    _sideEffectController.close();
    return super.close();
  }
}
