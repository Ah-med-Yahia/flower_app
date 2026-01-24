import 'package:flutter/material.dart';

import '../../../../../../core/theme/app_colors.dart';
import 'order_and_address_section.dart';

class LogoutSection extends StatelessWidget {
  const LogoutSection({super.key});

  Widget _logoutIC({required IconThemeData iconThemeData}) {
    return IconTheme(data: iconThemeData, child: const Icon(Icons.logout));
  }

  @override
  Widget build(BuildContext context) {
    var iconTheme = Theme.of(context).iconTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: ProfileCardItem(
        showIcon: false,
        leadingWidget: _logoutIC(
          iconThemeData: iconTheme.copyWith(color: AppColors.textPrimary),
        ),
        title: 'Logout',
        showArrow: false,
        trailingWidget: _logoutIC(
          iconThemeData: iconTheme.copyWith(color: AppColors.textSecondary),
        ),
      ),
    );
  }
}
