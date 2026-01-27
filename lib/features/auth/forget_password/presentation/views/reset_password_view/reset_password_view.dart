import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../config/di/di.dart';
import '../../../../../../core/constants/app_text_constants.dart';
import '../../../../../../core/widgets/spacing.dart';
import '../../view_models/reset_password/reset_password_cubit.dart';
import '../shared_widgets/custom_header_title_widget.dart';
import 'reset_password_body.dart';

class ResetPasswordView extends StatelessWidget {
  const ResetPasswordView({super.key, required this.email});

  final String email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppTextConstants.password),
        leading: InkWell(
          onTap: () {
            context.pop();
          },
          child: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
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
                create: (context) => getIt<ResetPasswordCubit>(),
                child: ResetPasswordBody(email: email),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
