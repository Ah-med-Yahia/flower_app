import 'package:flower_app/core/constants/app_routes_constant.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../../core/constants/app_text_constants.dart';
import '../../../../../../../core/theme/app_colors.dart';
import '../../../../../../../core/shared/presentation/widgets/spacing.dart';

class OrderAndAddressSection extends StatelessWidget {
  const OrderAndAddressSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsGeometry.symmetric(horizontal: 16),
      child: Column(
        children: [
          ProfileCardItem(
            title: AppTextConstants.myOrders,
            icon: Icons.shopping_bag_outlined,
          ),
          InkWell(
            onTap: () {
              context.push(AppRoutesConstants.savedAddressesRoute);
            },
            child: ProfileCardItem(
              title: AppTextConstants.savedAddresses,
              icon: Icons.location_on_outlined,
            ),
          ),
        ],
      ),
    );
  }
}

class ProfileCardItem extends StatelessWidget {
  final dynamic icon;
  final String title;
  final Widget? leadingWidget;
  final Widget? trailingWidget;
  final bool showIcon;
  final bool showArrow;

  const ProfileCardItem({
    super.key,
    this.showIcon = true,
    this.icon,
    required this.title,
    this.leadingWidget,
    this.trailingWidget,
    this.showArrow = true,
  });

  @override
  Widget build(BuildContext context) {
    final iconTheme = Theme.of(context).iconTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 11.0),
      child: Row(
        children: [
          showIcon
              ? IconTheme(
                  data: iconTheme.copyWith(color: AppColors.black),
                  child: Icon(icon ?? Icons.location_on_outlined),
                )
              : leadingWidget ?? const SizedBox.shrink(),
          4.horizontalSpacing,
          Text(title, style: Theme.of(context).textTheme.titleSmall),
          const Spacer(),
          if (trailingWidget != null)
            trailingWidget!
          else if (showArrow)
            IconTheme(
              data: iconTheme.copyWith(color: AppColors.textSecondary),
              child: const Icon(Icons.arrow_forward_ios_outlined),
            ),
        ],
      ),
    );
  }
}
