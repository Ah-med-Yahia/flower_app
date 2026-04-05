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
  int notificationCount = 3;
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return InkWell(
      onTap: () {
        setState(() {
          notificationCount = 0;
        });
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
                    '3',
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
