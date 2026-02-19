import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../config/di/di.dart';
import '../../../../../../core/constants/app_text_constants.dart';
import '../../../../../../core/shared/presentation/widgets/spacing.dart';
import '../../view_models/forget_password/forget_password_cubit.dart';
import '../shared_widgets/custom_header_title_widget.dart';
import 'forget_password_body.dart';

class ForgetPasswordView extends StatelessWidget {
  const ForgetPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppTextConstants.password),
        leading: InkWell(
          onTap: () {
            context.pop();
          },
          child: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            40.verticalSpacing,
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: CustomHeaderTitleWidget(
                headerTitle: AppTextConstants.forgetPasswordHeader,
                subTitle: AppTextConstants.forgetPasswordTitle,
              ),
            ),
            32.verticalSpacing,
            BlocProvider<ForgetPasswordCubit>(
              create: (context) => getIt<ForgetPasswordCubit>(),
              child: const ForgetPasswordBody(),
            ),
          ],
        ),
      ),
    );
  }
}
