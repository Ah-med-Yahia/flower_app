import 'package:flower_app/config/di/di.dart';
import 'package:flower_app/core/constants/app_text_constants.dart';
import 'package:flower_app/core/gen/assets.gen.dart';
import 'package:flower_app/core/shared/presentation/widgets/lottie_states_widget.dart';
import 'package:flower_app/core/theme/app_colors.dart';
import 'package:flower_app/core/ui_utils/ui_utils.dart';
import 'package:flower_app/features/tabs/profile/profile_main/presentation/cubit/notifications/notifications_cubit.dart';
import 'package:flower_app/features/tabs/profile/profile_main/presentation/cubit/notifications/notifications_intents.dart';
import 'package:flower_app/features/tabs/profile/profile_main/presentation/cubit/notifications/notifications_side_effect.dart';
import 'package:flower_app/features/tabs/profile/profile_main/presentation/cubit/notifications/notifications_state.dart';
import 'package:flower_app/features/tabs/profile/profile_main/presentation/models_ui/notification.dart';
import 'package:flower_app/features/tabs/profile/profile_main/presentation/screens/widget/notification_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  List<AppNotification> notifications = [];

  late final TextTheme textTheme;
  late final NotificationsCubit notificationsCubit;
  late Size screenSize;

  @override
  void initState() {
    super.initState();
    notificationsCubit = getIt<NotificationsCubit>();
    notificationsCubit.sideEffectStream.listen((sideEffect) {
      if (mounted) {
        switch (sideEffect) {
          case LoadNotifications():
            UIUtils.showLoading(context);
          case HideLoading():
            UIUtils.hideLoading(context);
          case MarkAllAsSeen():
            notificationsCubit.doIntent(MarkAllAsSeenIntent());
        }
      }
    });
    notificationsCubit.doIntent(GetNotificationsIntent());
  }

  @override
  didChangeDependencies() {
    super.didChangeDependencies();
    textTheme = Theme.of(context).textTheme;
    screenSize = MediaQuery.sizeOf(context);
  }

  @override
  void dispose() {
    notificationsCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => notificationsCubit,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.white,
          title: Text(
            AppTextConstants.notifications,
            style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
          ),
          leadingWidth: 30,
        ),
        body: BlocBuilder<NotificationsCubit, NotificationsState>(
          builder: (context, state) {
            final notifications = state.notifications;
            if (notifications == null || notifications.isEmpty) {
              return LottieStatesWidget(
                lottie: Assets.lottie.emptyBox.path,
                text: AppTextConstants.noNotifications,
                textColor: AppColors.primary,
                height: screenSize.height * 0.5,
                width: screenSize.width * 0.5,
              );
            }
            return ListView.separated(
              physics: const BouncingScrollPhysics(),
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                final notification = notifications[index];
                return NotificationCard(notification: notification);
              },
              separatorBuilder: (context, index) {
                return const SizedBox(height: 8);
              },
            );
          },
        ),
      ),
    );
  }
}
