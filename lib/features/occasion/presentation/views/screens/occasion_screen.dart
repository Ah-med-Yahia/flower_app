import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../config/di/di.dart';
import '../../../../../core/constants/app_text_constants.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/loading_indicator_widget.dart';
import '../../view_model/occasion_cubit.dart';
import '../../view_model/occasion_event.dart';
import '../../view_model/occasion_state.dart';
import '../widgets/app_bar_title.dart';
import '../widgets/back_button.dart';
import '../widgets/occasion_tab_bar.dart';
import '../widgets/products_grid.dart';

class OccasionScreen extends StatelessWidget {
  const OccasionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<OccasionCubit>()..onEvent(GetAllOccasions()),
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: MediaQuery.of(context).size.height * 0.09,
          leading: const BackButtonWidget(),
          title: const AppBarTitle(),
          surfaceTintColor: Colors.transparent,
        ),
        body: SafeArea(
          top: false,
          child: BlocBuilder<OccasionCubit, OccasionState>(
            builder: (context, state) {
              if (state.occasionState.isLoading) {
                return Align(
                  alignment: Alignment.topCenter,
                  child: Text(
                    AppTextConstants.loading,
                    style: Theme.of(
                      context,
                    ).textTheme.titleMedium!.copyWith(color: AppColors.grey),
                  ),
                );
              }

              if (state.occasionState.errorMessage != null) {
                return Align(
                  alignment: Alignment.topCenter,
                  child: Text(
                    state.occasionState.errorMessage!,
                    style: Theme.of(
                      context,
                    ).textTheme.titleMedium!.copyWith(color: AppColors.darkRed),
                  ),
                );
              }

              final occasions = state.occasionState.data?.occasions ?? [];

              if (occasions.isEmpty) {
                return Align(
                  alignment: Alignment.topCenter,
                  child: Text(
                    AppTextConstants.noOccasionsAvailable,
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: AppColors.darkRed,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                );
              }

              return Column(
                children: [
                  const SizedBox(height: 8),
                  OccasionTabBar(
                    occasions: occasions,
                    selectedIndex: state.selectedIndex,
                    onTabSelected: (index) {
                      context.read<OccasionCubit>().onEvent(
                        SelectOccasion(index),
                      );
                    },
                  ),
                  BlocBuilder<OccasionCubit, OccasionState>(
                    builder: (productContext, productState) {
                      if (productState.occasionProductsState.isLoading) {
                        return const Expanded(
                          child: LoadingIndicator(size: 130),
                        );
                      }

                      if (productState.occasionProductsState.errorMessage !=
                          null) {
                        return Center(
                          child: Text(
                            productState.occasionProductsState.errorMessage!,
                            style: Theme.of(context).textTheme.titleMedium!
                                .copyWith(color: AppColors.darkRed),
                          ),
                        );
                      }
                      final occasionsProducts =
                          productState.occasionProductsState.data?.products;

                      if (occasionsProducts == null) {
                        return Expanded(
                          child: Center(
                            child: Text(
                              AppTextConstants.noProductsAvailable,
                              style: Theme.of(context).textTheme.titleLarge!
                                  .copyWith(
                                    color: AppColors.darkRed,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                            ),
                          ),
                        );
                      }
                      return ProductsGrid(occasionsProducts);
                    },
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
