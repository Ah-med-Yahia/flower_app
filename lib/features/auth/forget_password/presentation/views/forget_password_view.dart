import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_exam_app/config/di/di.dart';
import '../manager/forget_password_cubit.dart';
import 'forget_password_body.dart';

class ForgetPasswordView extends StatelessWidget {
  const ForgetPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ForgetPasswordCubit>(),
      child: const ForgetPasswordBody(),
    );
  }
}
