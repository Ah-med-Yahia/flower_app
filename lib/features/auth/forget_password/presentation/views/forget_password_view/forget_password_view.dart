import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_exam_app/config/di/di.dart';

import '../../../../../../core/constants/app_text_constants.dart';
import '../../view_models/forget_password/forget_password_cubit.dart';
import 'forget_password_body.dart';

class ForgetPasswordView extends StatelessWidget {
  ForgetPasswordView({super.key});

  final ForgetPasswordCubit cubit = getIt<ForgetPasswordCubit>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppTextConstants.password),
        leading: Icon(Icons.arrow_back_ios),
      ),
      body: BlocProvider<ForgetPasswordCubit>(
        create: (context) => cubit,
        child: ForgetPasswordBody(cubit: cubit),
      ),
    );
  }
}
