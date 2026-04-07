import 'package:flower_app/core/constants/app_text_constants.dart';
import 'package:flower_app/core/theme/app_colors.dart';
import 'package:flower_app/features/tabs/profile/profile_main/presentation/screens/widget/notification_card.dart';
import 'package:flutter/material.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.grey,
        title: Text(
          AppTextConstants.notifications,
          style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
        ),
        leadingWidth: 30,
      ),
      body: ListView.separated(
        itemCount: 10,
        itemBuilder: (context, index) {
          return const NotificationCard();
        },
        separatorBuilder: (context, index) {
          return const Divider(color: Colors.grey, thickness: 1, height: 1);
        },
      ),
    );
  }
}
