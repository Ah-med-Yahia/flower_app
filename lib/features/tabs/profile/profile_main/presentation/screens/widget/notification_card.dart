import 'package:flower_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class NotificationCard extends StatefulWidget {
  const NotificationCard({super.key});
  @override
  State<NotificationCard> createState() => _NotificationCardState();
}

class _NotificationCardState extends State<NotificationCard> {
  bool ta = false;
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return InkWell(
      onTap: () {
        setState(() {
          ta = true;
        });
      },
      child: Container(
        padding: const EdgeInsets.all(8),
        margin: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          // color: AppColors.lightGrey
          color: ta ? AppColors.lightGrey2 : AppColors.lightGrey,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Notification Title',
              style: textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Notification body text goes here. This is a sample notification.',
              style: textTheme.bodyMedium,
            ),
            const SizedBox(height: 12),
            Text(
              '2 hours ago',
              style: textTheme.bodySmall?.copyWith(color: AppColors.white),
            ),
          ],
        ),
      ),
    );
  }
}
