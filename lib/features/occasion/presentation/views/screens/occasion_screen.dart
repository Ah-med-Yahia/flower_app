import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flower_app/config/di/di.dart';
import 'package:flower_app/core/constants/app_text_constants.dart';
import 'package:flower_app/core/theme/app_colors.dart';
import 'package:flower_app/core/widgets/loading_indicator_widget.dart';
import 'package:flower_app/features/occasion/presentation/view_model/occasion_cubit.dart';
import 'package:flower_app/features/occasion/presentation/view_model/occasion_event.dart';
import 'package:flower_app/features/occasion/presentation/view_model/occasion_state.dart';
import 'package:flower_app/features/occasion/presentation/views/widgets/app_bar_title.dart';
import 'package:flower_app/features/occasion/presentation/views/widgets/back_button.dart';
import 'package:flower_app/features/occasion/presentation/views/widgets/occasion_tab_bar.dart';
import 'package:flower_app/features/occasion/presentation/views/widgets/products_grid.dart';

class OccasionScreen extends StatelessWidget {
  final String? id;
  const OccasionScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          getIt<OccasionCubit>()
            ..onEvent(GetAllOccasions(initialOccasionId: id)),
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
                        return Expanded(child: LoadingIndicator(size: 130));
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
                      final occasionsproducts =
                          productState.occasionProductsState.data?.products;

                      if (occasionsproducts == null) {
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
                      return ProductsGrid(occasionsproducts);
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
