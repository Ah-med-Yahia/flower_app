import 'package:flower_app/config/di/di.dart';
import 'package:flower_app/core/constants/app_text_constants.dart';
import 'package:flower_app/core/gen/assets.gen.dart';
import 'package:flower_app/core/theme/app_colors.dart';
import 'package:flower_app/core/widgets/loading_indicator_widget.dart';
import 'package:flower_app/features/orders/presentation/views/widgets/orders_appbar.dart';
import 'package:flower_app/features/orders/presentation/views/widgets/orders_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flower_app/features/orders/domain/usecases/get_user_orders_usecase.dart';
import 'package:flower_app/features/orders/presentation/view_model/orders_cubit.dart';
import 'package:flower_app/features/orders/presentation/view_model/orders_event.dart';
import 'package:flower_app/features/orders/presentation/view_model/orders_state.dart';
import 'package:lottie/lottie.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          getIt<OrdersCubit>()
            ..onEvent(GetOrdersEvent(filter: OrderFilter.active)),
      child: Scaffold(
        appBar: OrdersAppBar(tabController: tabController),
        body: BlocBuilder<OrdersCubit, OrdersState>(
          builder: (context, state) {
            if (state.ordersState.isLoading) {
              return const LoadingIndicator();
            }

            if (state.ordersState.errorMessage != null &&
                state.ordersState.data == null) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Lottie.asset(
                      Assets.lottie.error.path,
                      width: 150,
                      height: 150,
                      repeat: false,
                    ),
                    Text(
                      state.ordersState.errorMessage!,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: AppColors.red,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: 150,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () => context.read<OrdersCubit>().onEvent(
                          GetOrdersEvent(
                            filter: tabController.index == 0
                                ? OrderFilter.active
                                : OrderFilter.completed,
                          ),
                        ),
                        child: Text(AppTextConstants.retry),
                      ),
                    ),
                  ],
                ),
              );
            }

            final orders = state.ordersState.data?.orders ?? [];

            if (orders.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Lottie.asset(
                      Assets.lottie.emptyBox.path,
                      width: 200,
                      height: 200,
                      repeat: false,
                    ),
                    Text(
                      AppTextConstants.noOrdersAvailable,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              );
            }

            return TabBarView(
              controller: tabController,
              children: [
                OrdersList(orders: orders, isActive: true),
                OrdersList(orders: orders, isActive: false),
              ],
            );
          },
        ),
      ),
    );
  }
}
