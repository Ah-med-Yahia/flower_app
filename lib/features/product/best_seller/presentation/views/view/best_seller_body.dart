import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../../../core/constants/app_text_constants.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/widgets/loading_indicator_widget.dart';
import '../../../../../../core/widgets/spacing.dart';
import '../../view_models/best_seller_cubit.dart';
import '../../view_models/best_seller_events.dart';
import '../../view_models/best_seller_state.dart';
import '../widget/grid_view_widget.dart';
import 'package:flower_app/core/constants/app_routes_constant.dart';

class BestSellerBody extends StatefulWidget {
  const BestSellerBody({super.key});

  @override
  State<BestSellerBody> createState() => _BestSellerBodyState();
}

class _BestSellerBodyState extends State<BestSellerBody> {
  StreamSubscription<BestSellerEvents>? _subscription;
  late final BestSellerCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = context.read<BestSellerCubit>();
    _getData();
    _subscribeToEvents();
  }

  void _getData() => cubit.doIntent(const GetBestSellerProductEvent());

  void _subscribeToEvents() {
    _subscription = cubit.uiEvents.listen((event) {
      if (!mounted) return;
      if (event case NavigateToProductDetailsEvent()) {
        context.pushNamed(
          AppRoutesConstants.productDetailsRoute,
          extra: event.productId,
        );
        return;
      }
      if (event case NavigateToCartEvent()) {
        return;
      }
    });
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  Widget _errorWidget({required String errorMessage}) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, size: 64, color: AppColors.red),
          16.verticalSpacing,
          Text(
            errorMessage,
            style: const TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),
          16.verticalSpacing,
          ElevatedButton(
            onPressed: _getData,
            child: Text(AppTextConstants.retry.tr()),
          ),
        ],
      ),
    );
  }

  Widget _noProductsWidget() {
    return Center(child: Text(AppTextConstants.noProductsAvailable.tr()));
  }

  Widget _loadingWidget() {
    return const Center(child: LoadingIndicator());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BestSellerCubit, BestSellerState>(
      builder: (context, state) {
        if (state.bestSellerState.isLoading) return _loadingWidget();
        if (state.bestSellerState.errorMessage != null) {
          final errorMessage = state.bestSellerState.errorMessage ?? '';
          return _errorWidget(errorMessage: errorMessage);
        }
        if (state.bestSellerList == null || state.bestSellerList!.isEmpty) {
          return _noProductsWidget();
        }
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
          child: GridViewWidget(),
        );
      },
    );
  }
}
