import 'package:flower_app/core/constants/app_text_constants.dart';
import 'package:flower_app/core/theme/app_colors.dart';
import 'package:flower_app/features/orders/domain/usecases/get_user_orders_usecase.dart';
import 'package:flower_app/features/orders/presentation/view_model/orders_cubit.dart';
import 'package:flower_app/features/orders/presentation/view_model/orders_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrdersTabBar extends StatelessWidget implements PreferredSizeWidget {
  final TabController controller;

  const OrdersTabBar({super.key, required this.controller});

  @override
  Size get preferredSize => const Size.fromHeight(48);
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: TabBar(
        onTap: (index) {
          final filter = index == 0
              ? OrderFilter.active
              : OrderFilter.completed;
          context.read<OrdersCubit>().onEvent(GetOrdersEvent(filter: filter));
        },
        controller: controller,
        indicatorSize: TabBarIndicatorSize.tab,
        labelColor: AppColors.primary,
        unselectedLabelColor: AppColors.textSecondary,
        indicatorColor: AppColors.primary,
        indicatorWeight: 2,
        labelStyle: theme.textTheme.titleMedium!.copyWith(fontSize: 18),
        tabs: [
          Tab(text: AppTextConstants.activeText),
          Tab(text: AppTextConstants.completedText),
        ],
      ),
    );
  }
}
