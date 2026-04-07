import 'dart:async';

import 'package:flower_app/config/services/notifications_services.dart';
import 'package:flower_app/core/constants/app_routes_constant.dart';
import 'package:flower_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NotificationIcon extends StatefulWidget {
  const NotificationIcon({super.key});

  @override
  State<NotificationIcon> createState() => _NotificationIconState();
}

class _NotificationIconState extends State<NotificationIcon> {
  int notificationCount = 0;
  late final StreamSubscription<int> _subscription;
  @override
  void initState() {
    super.initState();
    notificationCount = NotificationService().count;
    _subscription = NotificationService().countStream.listen((count) {
      if (mounted) {
        setState(() {
          notificationCount = count;
        });
      }
    });
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return InkWell(
      onTap: () {
        NotificationService().reset();
        context.pushNamed(AppRoutesConstants.notificationRoute);
      },
      child: Stack(
        children: [
          const Icon(Icons.notifications_none, color: AppColors.grey),
          Visibility(
            visible: notificationCount > 0,
            child: Positioned(
              right: 2,
              top: 0,
              child: Container(
                width: 16,
                height: 16,
                decoration: const BoxDecoration(
                  color: AppColors.red,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    notificationCount > 99 ? '99+' : '$notificationCount',
                    style: textTheme.bodySmall?.copyWith(
                      color: AppColors.background,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
