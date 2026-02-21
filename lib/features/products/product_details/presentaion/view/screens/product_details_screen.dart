import 'dart:async';

import 'package:flower_app/core/constants/app_routes_constant.dart';
import 'package:flower_app/core/constants/app_text_constants.dart';
import 'package:flower_app/core/shared/presentation/cubits/products_cubit/products_cubit.dart';
import 'package:flower_app/core/shared/presentation/cubits/products_cubit/products_side_effect.dart';
import 'package:flower_app/core/shared/presentation/widgets/add_remove_button.dart';
import 'package:flower_app/core/shared/presentation/widgets/spacing.dart';
import 'package:flower_app/core/theme/app_colors.dart';
import 'package:flower_app/features/tabs/cart/presentation/widgets/confirmation_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../config/di/di.dart';
import '../../../../../../core/constants/errors_constants.dart';
import '../../../../../../core/shared/presentation/widgets/custom_error_widget.dart';
import '../../../../../../core/shared/presentation/widgets/loading_indicator_widget.dart';
import '../../view_model/product_details_cubit.dart';
import '../../view_model/product_details_events.dart';
import '../../view_model/product_details_states.dart';
import '../widgets/product_details_info.dart';
import '../widgets/product_images_slider.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key, required this.productId});

  final String productId;

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  late StreamSubscription<ProductsSideEffect> _sideEffectSubscription;
  @override
  void initState() {
    super.initState();
    _sideEffectSubscription = context
        .read<ProductsCubit>()
        .sideEffectStream
        .listen((event) {
          if (event is LogoutUser) {
            _handleLogoutUser();
          }
        });
  }

  void _handleLogoutUser() {
    showDialog(
      context: context,
      builder: (context) {
        return ConfirmationDialog(
          message: AppTextConstants.mustLogin,
          onConfirm: () {
            context.pushNamed(AppRoutesConstants.loginRoute);
          },
          title: AppTextConstants.attention,
        );
      },
    );
  }

  @override
  void dispose() {
    _sideEffectSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ProductDetailsCubit cubit = getIt<ProductDetailsCubit>();
    return BlocProvider<ProductDetailsCubit>(
      create: (context) =>
          cubit..onEvent(GetProductDetailsEvent(widget.productId)),
      child: BlocBuilder<ProductDetailsCubit, ProductDetailsStates>(
        builder: (context, state) {
          if ((state.productDetailsState?.errorMessage?.isNotEmpty ?? false) &&
              state.productDetailsState?.errorMessage != null &&
              state.productDetailsState?.isLoading == false) {
            return Scaffold(
              body: CustomErrorWidget(
                error:
                    state.productDetailsState?.errorMessage ??
                    ErrorsConstant.defaultError,
                onTryAgain: () {
                  cubit.onEvent(GetProductDetailsEvent(widget.productId));
                },
              ),
            );
          }

          if (state.productDetailsState?.isLoading == true) {
            return const Scaffold(body: Center(child: LoadingIndicator()));
          }

          if (state.productDetailsState?.data != null &&
              state.productDetailsState?.isLoading == false) {
            final isInStock = state.productDetailsState!.data!.product.inStock;
            final priceAfterDiscount =
                state.productDetailsState!.data!.product.priceAfterDiscount;
            final priceBeforeDiscount =
                state.productDetailsState!.data!.product.price;
            final title = state.productDetailsState!.data!.product.title;
            final description =
                state.productDetailsState!.data!.product.description;
            final original =
                state.productDetailsState!.data!.product.images ?? [];
            final images = List<String>.from(original);
            final cover = state.productDetailsState!.data!.product.imageCover;
            if (cover != null && cover.isNotEmpty) {
              images.remove(cover);
              images.insert(0, cover);
            }

            return Scaffold(
              body: CustomScrollView(
                slivers: [
                  SliverAppBar(
                    expandedHeight: MediaQuery.of(context).size.height * 0.5,
                    flexibleSpace: FlexibleSpaceBar(
                      background: images.isNotEmpty == true
                          ? ProductImagesSlider(images: images)
                          : Column(
                              children: [
                                Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.5,
                                  color: AppColors.lightPink,
                                  child: Center(
                                    child: Icon(
                                      Icons.image_not_supported,
                                      size:
                                          MediaQuery.of(context).size.height *
                                          0.12,
                                      color: AppColors.grey,
                                    ),
                                  ),
                                ),
                                12.verticalSpacing,
                              ],
                            ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: ProductDetailsInfo(
                      priceAfterDiscount: priceAfterDiscount,
                      priceBeforeDiscount: priceBeforeDiscount,
                      isInStock: isInStock,
                      title: title,
                      description: description,
                    ),
                  ),
                ],
              ),
              bottomNavigationBar: Padding(
                padding: const EdgeInsets.all(16),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.06,
                  child: AddRemoveButton(
                    productId: widget.productId,
                    productInStock: isInStock,
                  ),
                ),
              ),
            );
          } else {
            return Scaffold(
              body: CustomErrorWidget(
                error: ErrorsConstant.notFoundError,
                onTryAgain: () {
                  cubit.onEvent(GetProductDetailsEvent(widget.productId));
                },
              ),
            );
          }
        },
      ),
    );
  }
}
