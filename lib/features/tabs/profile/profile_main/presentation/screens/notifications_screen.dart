import 'package:flower_app/core/constants/app_text_constants.dart';
import 'package:flutter/material.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppTextConstants.notifications,
          style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
        ),
        leadingWidth: 30,
      ),
      body: const Center(child: Text('Notifications')),
    );
  }
}
