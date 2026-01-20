import 'package:easy_localization/easy_localization.dart';
import 'package:flower_app/features/product/best_seller/presentation/view_models/best_seller_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../config/di/di.dart';
import '../../../../../../core/constants/app_text_constants.dart';
import 'best_seller_body.dart';

class BestSellerView extends StatelessWidget {
  const BestSellerView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppTextConstants.bestSeller.tr()),
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
      ),
      body: BlocProvider<BestSellerCubit>(
        create: (context) => getIt<BestSellerCubit>(),
        child: BestSellerBody(),
      ),
    );
  }
}
