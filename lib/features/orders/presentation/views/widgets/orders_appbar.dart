import 'package:flower_app/core/constants/app_text_constants.dart';
import 'package:flower_app/features/orders/presentation/views/widgets/orders_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class OrdersAppBar extends StatelessWidget implements PreferredSizeWidget {
  final TabController tabController;
  const OrdersAppBar({super.key, required this.tabController});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AppBar(
      titleSpacing: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios),
        onPressed: () => context.pop(),
      ),
      title: Text(
        AppTextConstants.myOrders,
        style: theme.appBarTheme.titleTextStyle,
      ),
      bottom: OrdersTabBar(controller: tabController),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 48);
}
