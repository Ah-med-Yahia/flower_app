import 'dart:async';

import 'package:flower_app/core/widgets/spacing.dart';
import 'package:flower_app/features/product/best_seller/presentation/view_models/best_seller_events.dart';
import 'package:flower_app/features/product/best_seller/presentation/view_models/best_seller_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/constants/app_text_constants.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/widgets/loading_indicator_widget.dart';
import '../../view_models/best_seller_cubit.dart';
import '../widget/grid_View_widget.dart';

class BestSellerBody extends StatefulWidget {
  final BestSellerCubit cubit;

  const BestSellerBody({super.key, required this.cubit});

  @override
  State<BestSellerBody> createState() => _BestSellerBodyState();
}

class _BestSellerBodyState extends State<BestSellerBody> {
  StreamSubscription<BestSellerEvents>? _subscription;

  @override
  void initState() {
    super.initState();
    _getData();
    _subscribeToEvents();
  }

  void _getData() => widget.cubit.doIntent(const GetBestSellerProductEvent());

  void _subscribeToEvents() {
    _subscription = widget.cubit.uiEvents.listen((event) {
      if (!mounted) return;
      if (event case NavigateToProductDetailsEvent()) {
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
            child: const Text(AppTextConstants.retry),
          ),
        ],
      ),
    );
  }

  Widget _noProductsWidget() {
    return const Center(child: Text(AppTextConstants.noProductsAvailable));
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
          child: GridViewWidget(cubit: widget.cubit),
        );
      },
    );
  }
}
