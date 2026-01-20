import 'package:easy_localization/easy_localization.dart';
import 'package:flower_app/config/di/di.dart';
import 'package:flower_app/core/constants/app_text_constants.dart';
import 'package:flower_app/core/constants/errors_constants.dart';
import 'package:flower_app/core/widgets/custom_eleveted_button.dart';
import 'package:flower_app/core/widgets/custom_error_widget.dart';
import 'package:flower_app/core/widgets/loading_indicator_widget.dart';
import 'package:flower_app/features/product_details/presentaion/view/widgets/product_details_info.dart';
import 'package:flower_app/features/product_details/presentaion/view/widgets/product_images_slider.dart';
import 'package:flower_app/features/product_details/presentaion/view_model/product_details_cubit.dart';
import 'package:flower_app/features/product_details/presentaion/view_model/product_details_events.dart';
import 'package:flower_app/features/product_details/presentaion/view_model/product_details_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({super.key, required this.productId});

  final String productId;

  @override
  Widget build(BuildContext context) {
    final ProductDetailsCubit cubit = getIt<ProductDetailsCubit>();
    return BlocProvider<ProductDetailsCubit>(
      create: (context) => cubit..onEvent(GetProductDetailsEvent(productId)),
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
                  cubit.onEvent(GetProductDetailsEvent(productId));
                },
              ),
            );
          }

          if (state.productDetailsState?.isLoading == true) {
            return Scaffold(body: Center(child: LoadingIndicator()));
          }

          if (state.productDetailsState?.data != null &&
              state.productDetailsState?.isLoading == false) {
            final priceAfterDiscount =
                state.productDetailsState!.data!.product.priceAfterDiscount;
            final priceBeforeDiscount =
                state.productDetailsState!.data!.product.price;
            final quantity = state.productDetailsState!.data!.product.quantity;
            final title = state.productDetailsState!.data!.product.title;
            final description =
                state.productDetailsState!.data!.product.description;
            final images = state.productDetailsState!.data!.product.images;
            images.add(state.productDetailsState!.data!.product.imgCover);
            return Scaffold(
              body: CustomScrollView(
                slivers: [
                  SliverAppBar(
                    expandedHeight: MediaQuery.of(context).size.height * 0.5,
                    flexibleSpace: FlexibleSpaceBar(
                      background: ProductImagesSlider(images: images),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: ProductDetailsInfo(
                      priceAfterDiscount: priceAfterDiscount,
                      priceBeforeDiscount: priceBeforeDiscount,
                      quantity: quantity,
                      title: title,
                      description: description,
                    ),
                  ),
                ],
              ),
              bottomNavigationBar: Padding(
                padding: const EdgeInsets.all(16),
                child: CustomElevatedButtonWidget(
                  onPressed: () {},
                  text: AppTextConstants.addToCart,
                ),
              ),
            );
          } else {
            return Scaffold(
              body: CustomErrorWidget(
                error: ErrorsConstant.notFound.tr(),
                onTryAgain: () {
                  cubit.onEvent(GetProductDetailsEvent(productId));
                },
              ),
            );
          }
        },
      ),
    );
  }
}
