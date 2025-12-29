import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_exam_app/core/widgets/spacing.dart';
import 'package:online_exam_app/features/auth/forget_password/presentation/views/reset_password_view/reset_password_body.dart';

import '../../../../../../config/di/di.dart';
import '../../../../../../core/constants/app_text_constants.dart';
import '../../view_models/reset_password/reset_password_cubit.dart';
import '../shared_widgets/custom_header_title_widget.dart';

class ResetPasswordView extends StatelessWidget {
  ResetPasswordView({super.key, required this.email});

  final String email;
  final ResetPasswordCubit cubit = getIt<ResetPasswordCubit>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppTextConstants.password),
        leading: const Icon(Icons.arrow_back_ios),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            // Text('Email: $email'),
            40.verticalSpacing,
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: const CustomHeaderTitleWidget(
                headerTitle: AppTextConstants.resetPasswordHeader,
                subTitle: AppTextConstants.resetPasswordTitle,
              ),
            ),
            32.verticalSpacing,
            BlocProvider<ResetPasswordCubit>(
              create: (context) => cubit,
              child: ResetPasswordBody(cubit: cubit, email: email),
            ),
          ],
        ),
      ),
    );
  }
}
