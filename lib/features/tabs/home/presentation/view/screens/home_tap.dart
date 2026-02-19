import 'package:flower_app/config/di/di.dart';
import 'package:flower_app/core/constants/app_routes_constant.dart';
import 'package:flower_app/core/constants/app_text_constants.dart';
import 'package:flower_app/core/constants/errors_constants.dart';
import 'package:flower_app/core/gen/assets.gen.dart';
import 'package:flower_app/core/shared/presentation/cubits/products_cubit/products_cubit.dart';
import 'package:flower_app/core/shared/presentation/cubits/products_cubit/products_state.dart';
import 'package:flower_app/core/theme/app_colors.dart';
import 'package:flower_app/core/shared/presentation/widgets/custom_error_widget.dart';
import 'package:flower_app/core/shared/presentation/widgets/loading_indicator_widget.dart';
import 'package:flower_app/core/shared/presentation/widgets/products_grid_widget.dart';
import 'package:flower_app/core/shared/presentation/widgets/spacing.dart';
import 'package:flower_app/core/shared/presentation/widgets/lottie_states_widget.dart';
import 'package:flower_app/features/tabs/home/presentation/view/widgets/address_widget.dart';
import 'package:flower_app/features/tabs/home/presentation/view/widgets/best_seller_section.dart';
import 'package:flower_app/features/tabs/home/presentation/view/widgets/categories_section.dart';
import 'package:flower_app/features/tabs/home/presentation/view/widgets/home_app_bar.dart';
import 'package:flower_app/features/tabs/home/presentation/view/widgets/occasion_section.dart';
import 'package:flower_app/features/tabs/home/presentation/view_model/home_screen_cubit.dart';
import 'package:flower_app/features/tabs/home/presentation/view_model/home_screen_events.dart';
import 'package:flower_app/features/tabs/home/presentation/view_model/home_screen_states.dart';
import 'package:flower_app/features/tabs/home/presentation/view_model/ui_events.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class HomeTap extends StatefulWidget {
  final VoidCallback onNavigateToCategories;
  final void Function(String categoryId) onNavigateSelectedToCategory;

  const HomeTap({
    super.key,
    required this.onNavigateToCategories,
    required this.onNavigateSelectedToCategory,
  });

  @override
  State<HomeTap> createState() => _HomeTapState();
}

class _HomeTapState extends State<HomeTap> {
  late final HomeScreenCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = getIt<HomeScreenCubit>();
    // Reset navigation event when widget initializes
    // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
    cubit.emit(
      HomeScreenStates(
        homeScreenStates: cubit.state.homeScreenStates,
        navigationEvent: null, // Clear any old navigation events
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    return BlocProvider(
      create: (context) => cubit..onEvent(GetHomeScreenDataEvent()),
      child: BlocListener<HomeScreenCubit, HomeScreenStates>(
        listener: (context, state) {
          final nav = state.navigationEvent;
          if (nav != null) {
            switch (nav) {
              case NavigateToProductDetailsEvent():
                context.pushNamed(
                  AppRoutesConstants.productDetailsRoute,
                  extra: nav.productId,
                );
              case NavigateToBestSellerScreenEvent():
                context.pushNamed(AppRoutesConstants.bestSellerRoute);
              case NavigateToCategoryEvent():
                widget.onNavigateSelectedToCategory(nav.categoryId!);
              case NavigateToOccasionEvent():
                context.pushNamed(
                  AppRoutesConstants.occasionScreen,
                  extra: nav.occasionId,
                );
            }
          }
        },
        child: BlocBuilder<HomeScreenCubit, HomeScreenStates>(
          builder: (context, state) {
            if ((state.homeScreenStates?.errorMessage?.isNotEmpty ?? false) &&
                state.homeScreenStates?.errorMessage != null &&
                state.homeScreenStates?.isLoading == false) {
              return Scaffold(
                body: CustomErrorWidget(
                  error:
                      state.homeScreenStates?.errorMessage ??
                      ErrorsConstant.defaultError,
                  onTryAgain: () {
                    cubit.onEvent(GetHomeScreenDataEvent());
                  },
                ),
              );
            }
            if (state.homeScreenStates?.isLoading == true) {
              return const Scaffold(body: Center(child: LoadingIndicator()));
            }
            if (state.homeScreenStates?.data != null &&
                state.homeScreenStates?.isLoading == false) {
              final homeScreenData = state.homeScreenStates!.data;
              return Scaffold(
                appBar: AppBar(toolbarHeight: height * 0.0),
                backgroundColor: AppColors.background,
                body: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 16.0,
                    horizontal: 12,
                  ),
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const HomeAppBar(),
                        12.verticalSpacing,
                        BlocBuilder<ProductsCubit, ProductsState>(
                          builder: (context, state) {
                            final ps = state.productsState;
                            final products = ps.data?.products;

                            if (ps.isLoading == true) {
                              return const Center(child: LoadingIndicator());
                            }

                            if (ps.errorMessage != null &&
                                ps.isLoading == false) {
                              return CustomErrorWidget(
                                error:
                                    ps.errorMessage ??
                                    ErrorsConstant.defaultError,
                              );
                            }

                            if (products?.isNotEmpty == true &&
                                ps.isLoading == false) {
                              return ProductsGridWidget(
                                products: ps.data!.products,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 0,
                                ),
                              );
                            }

                            if (products?.isEmpty == true &&
                                ps.isLoading == false) {
                              return LottieStatesWidget(
                                lottie: Assets.lottie.emptyBox.path,
                                text: AppTextConstants.noProductsAvailable,
                                textColor: AppColors.primary,
                                height:
                                    MediaQuery.of(context).size.height * 0.26,
                              );
                            }

                            return Column(
                              children: [
                                const AddressWidget(
                                  address: '2XVP+XC - Sheikh Zayed',
                                ),
                                12.verticalSpacing,
                                CategoriesSection(
                                  onNavigateToCategories:
                                      widget.onNavigateToCategories,
                                  cubit: cubit,
                                  categories: homeScreenData!.categories,
                                ),
                                BestSellerSection(
                                  cubit: cubit,
                                  bestSeller: homeScreenData.bestSeller,
                                ),
                                8.verticalSpacing,
                                OccasionSection(
                                  cubit: cubit,
                                  occasions: homeScreenData.occasions,
                                ),
                              ],
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
