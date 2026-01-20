import 'package:easy_localization/easy_localization.dart';
import 'package:flower_app/core/widgets/spacing.dart';
import 'package:flower_app/features/auth/forget_password/presentation/views/verify_otp_view/verify_otp_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../config/di/di.dart';
import '../../../../../../core/constants/app_text_constants.dart';
import '../../view_models/verify_otp/verify_otp_code_cubit.dart';
import '../shared_widgets/custom_header_title_widget.dart';

class VerifyOtpView extends StatelessWidget {
  VerifyOtpView({super.key, required this.email});

  final VerifyOtpCodeCubit cubit = getIt<VerifyOtpCodeCubit>();
  final String email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppTextConstants.password.tr()),
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
                headerTitle: AppTextConstants.emailVerificationHeader.tr(),
                subTitle: AppTextConstants.emailVerificationTitle.tr(),
              ),
            ),
            32.verticalSpacing,
            BlocProvider<VerifyOtpCodeCubit>(
              create: (context) => cubit,
              child: VerifyOtpBody(cubit: cubit, email: email),
            ),
          ],
        ),
      ),
    );
  }
}
