import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../config/di/di.dart';
import '../../../../../../core/constants/app_text_constants.dart';
import '../../../../../../core/widgets/spacing.dart';
import '../../view_models/verify_otp/verify_otp_code_cubit.dart';
import '../shared_widgets/custom_header_title_widget.dart';
import 'verify_otp_body.dart';

class VerifyOtpView extends StatelessWidget {
  VerifyOtpView({super.key, required this.email});

  final VerifyOtpCodeCubit cubit = getIt<VerifyOtpCodeCubit>();
  final String email;

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
                headerTitle: AppTextConstants.emailVerificationHeader,
                subTitle: AppTextConstants.emailVerificationTitle,
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
