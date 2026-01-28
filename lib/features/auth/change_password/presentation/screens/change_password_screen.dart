import 'package:flower_app/config/di/di.dart';
import 'package:flower_app/core/constants/app_text_constants.dart';
import 'package:flower_app/core/theme/app_colors.dart';
import 'package:flower_app/core/ui_utils/ui_utils.dart';
import 'package:flower_app/core/validators/app_validators.dart';
import 'package:flower_app/features/auth/change_password/presentation/cubit/change_password_cubit.dart';
import 'package:flower_app/features/auth/change_password/presentation/cubit/change_password_intents.dart';
import 'package:flower_app/features/auth/change_password/presentation/cubit/change_pasword_ui_intents.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  late final ChangePasswordCubit _passwordCubit;
  final formKey = GlobalKey<FormState>();
  final _currentPassword = TextEditingController();
  final _newpassword = TextEditingController();
  final _confirmPassword = TextEditingController();

  @override
  void initState() {
    super.initState();
    _passwordCubit = getIt<ChangePasswordCubit>();

    _currentPassword.addListener(() {
      _passwordCubit.doIntent(CurrentPasswordChanged(_currentPassword.text));
    });

    _newpassword.addListener(() {
      _passwordCubit.doIntent(NewPasswordChanged(_newpassword.text));
    });

    _confirmPassword.addListener(() {
      _passwordCubit.doIntent(ConfirmPasswordChanged(_confirmPassword.text));
    });

    _passwordCubit.uiInenet.listen((intent) {
      if (!mounted) return;

      switch (intent) {
        case ShowLoadingIntent():
          UIUtils.showLoading(context);

        case ShowErrorIntent():
          UIUtils.showMessage(
            intent.message,
            backGroundColor: AppColors.red,
            textColor: AppColors.background,
          );
          break;
        case NavigateToEditProfileIntent():
          UIUtils.hideLoading(context);
          UIUtils.showMessage(
            intent.message,
            backGroundColor: AppColors.green,
            textColor: AppColors.background,
          );
          Navigator.of(context).pop();
      }
    });
  }

  @override
  void dispose() {
    _currentPassword.dispose();
    _newpassword.dispose();
    _confirmPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _passwordCubit,
      child: Scaffold(
        appBar: AppBar(title: const Text(AppTextConstants.resetPassword)),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                const SizedBox(height: 10),
                TextFormField(
                  controller: _currentPassword,
                  decoration: const InputDecoration(
                    label: Text(AppTextConstants.currentPassword),
                    hintText: AppTextConstants.currentPassword,
                    helperText: '',
                  ),
                  validator: AppValidators.validatePassword,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _newpassword,
                  decoration: const InputDecoration(
                    label: Text(AppTextConstants.newPassword),
                    hintText: AppTextConstants.newPassword,
                    helperText: '',
                  ),
                  validator: AppValidators.validatePassword,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
                const SizedBox(height: 10),

                TextFormField(
                  controller: _confirmPassword,
                  decoration:const InputDecoration(
                    label: Text(AppTextConstants.confirmPassword),
                    hintText: AppTextConstants.confirmPassword,
                    helperText: '',
                  ),
                  validator: (value) => AppValidators.validateConfirmPassword(
                    value,
                    _newpassword.text,
                  ),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
               const SizedBox(height: 40),
                SizedBox(
                  height: 48,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        _passwordCubit.doIntent(UpdateIntent());
                      }
                    },
                    child:const Text(
                      AppTextConstants.update,
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
