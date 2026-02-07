import 'dart:developer';

import 'package:flower_app/config/di/di.dart';
import 'package:flower_app/core/constants/app_routes_constant.dart';
import 'package:flower_app/core/constants/app_text_constants.dart';
import 'package:flower_app/core/constants/errors_constants.dart';
import 'package:flower_app/core/gen/assets.gen.dart';
import 'package:flower_app/core/theme/app_colors.dart';
import 'package:flower_app/core/widgets/custom_error_widget.dart';
import 'package:flower_app/core/widgets/loading_indicator_widget.dart';
import 'package:flower_app/features/home/presentation/view/widgets/address_widget.dart';
import 'package:flower_app/features/home/presentation/view/widgets/best_seller_occations_card_widget.dart';
import 'package:flower_app/features/home/presentation/view/widgets/category_card_widget.dart';
import 'package:flower_app/features/home/presentation/view/widgets/search_widget.dart';
import 'package:flower_app/features/home/presentation/view/widgets/view_all_button.dart';
import 'package:flower_app/features/home/presentation/view_model/home_screen_cubit.dart';
import 'package:flower_app/features/home/presentation/view_model/home_screen_events.dart';
import 'package:flower_app/features/home/presentation/view_model/home_screen_states.dart';
import 'package:flower_app/features/home/presentation/view_model/ui_events.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeTap extends StatelessWidget {
  final VoidCallback onNavigateToCategories;
  final void Function(String categoryId) onNavigateSelectedToCategory;

  const HomeTap({
    super.key,
    required this.onNavigateToCategories,
    required this.onNavigateSelectedToCategory,
  });

  @override
  Widget build(BuildContext context) {
    final titleLarge = Theme.of(context).textTheme.titleLarge;
    final double height = MediaQuery.of(context).size.height;
    final HomeScreenCubit cubit = getIt<HomeScreenCubit>();
    return BlocProvider(
      create: (context) => cubit..onEvent(GetHomeScreenDataEvent()),
      child: BlocListener<HomeScreenCubit, HomeScreenStates>(
        listenWhen: (previous, current) => current.navigationEvent != null,
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
                onNavigateSelectedToCategory(nav.categoryId!);
              case NavigateToOccasionEvent():
                context.pushNamed(AppRoutesConstants.occasionScreen);
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
              final data = state.homeScreenStates!.data;
              return Scaffold(
                appBar: AppBar(toolbarHeight: height * 0.0),
                backgroundColor: AppColors.background,
                body: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Assets.lottie.flower.svg(width: 24, height: 24),
                            const SizedBox(width: 4),
                            Text(
                              AppTextConstants.flowery,
                              style: titleLarge?.copyWith(
                                color: AppColors.primary,
                                fontWeight: FontWeight.bold,
                                fontFamily:
                                    GoogleFonts.imFellEnglish().fontFamily,
                              ),
                            ),
                            const SizedBox(width: 16),
                            const Expanded(child: SearchWidget()),
                          ],
                        ),
                        const SizedBox(height: 16),

                        const AddressWidget(address: '2XVP+XC - Sheikh Zayed'),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              AppTextConstants.categories,
                              style: titleLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            ViewAllButton(onPressed: onNavigateToCategories),
                          ],
                        ),
                        const SizedBox(height: 8),

                        SizedBox(
                          height: 120,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,

                            itemCount: data!.categories.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  cubit.onEvent(
                                    WhenCategoryIsClickedEvent(
                                      categoryId: data.categories[index].id,
                                    ),
                                  );
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 16.0),
                                  child: CategoryCardWidget(
                                    imageUrl: data.categories[index].image,
                                    label: data.categories[index].name,
                                    bgColor: AppColors.primary.withValues(
                                      alpha: 0.1,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              AppTextConstants.bestSeller,
                              style: titleLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            ViewAllButton(
                              onPressed: () {
                                cubit.onEvent(
                                  WhenViewAllBestSellerIsClickedEvent(),
                                );
                              },
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),

                        SizedBox(
                          height: 220,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: data.bestSeller.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(right: 16.0),
                                child: GestureDetector(
                                  onTap: () {
                                    log('best seller tapped');
                                    cubit.onEvent(
                                      WhenBestSellerIsClickedEvent(
                                        productId: data.bestSeller[index].id,
                                      ),
                                    );
                                  },
                                  child: BestSellerOccationsCardWidget(
                                    image: data.bestSeller[index].imgCover,
                                    title: data.bestSeller[index].title,
                                    price: data
                                        .bestSeller[index]
                                        .priceAfterDiscount
                                        .toInt()
                                        .toString(),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              AppTextConstants.occasion,
                              style: titleLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            ViewAllButton(
                              onPressed: () {
                                cubit.onEvent(
                                  WhenOccasionViewAllIsClickedEvent(),
                                );
                              },
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),

                        SizedBox(
                          height: 195,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: data.occasions.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(right: 16.0),
                                child: GestureDetector(
                                  onTap: () {
                                    cubit.onEvent(
                                      WhenOccasionIsClickedEvent(
                                        occasionId: data.occasions[index].id,
                                      ),
                                    );
                                  },
                                  child: BestSellerOccationsCardWidget(
                                    image: data.occasions[index].image,
                                    title: data.occasions[index].name,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 16),
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
