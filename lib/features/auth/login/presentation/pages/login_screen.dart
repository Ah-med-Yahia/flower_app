import 'package:flower_app/core/constants/app_text_constants.dart';
import 'package:flower_app/core/constants/app_routes_constant.dart';
import 'package:flower_app/core/theme/app_colors.dart';
import 'package:flower_app/core/ui_utils/ui_utils.dart';
import 'package:flower_app/core/validators/app_validators.dart';
import 'package:flower_app/core/widgets/spacing.dart';
import 'package:flower_app/features/auth/login/domain/entities/login_request_entity.dart';
import 'package:flower_app/features/auth/login/presentation/cubit/login_cubit.dart';
import 'package:flower_app/features/auth/login/presentation/cubit/login_intents.dart';
import 'package:flower_app/features/auth/login/presentation/cubit/login_state.dart';
import 'package:flower_app/features/auth/login/presentation/cubit/login_ui_events.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  late final LoginCubit loginCubit;
  late TextTheme textTheme;
  late Size screenSize;

  @override
  void initState() {
    super.initState();
    loginCubit = context.read<LoginCubit>();
    loginCubit.uiEvents.listen((event) {
      if (!mounted) return;
      switch (event) {
        case ShowLoading():
          UIUtils.showLoading(context);
        case ShowErrorMessage():
          UIUtils.hideLoading(context);
          UIUtils.showMessage(
            event.message,
            backGroundColor: AppColors.darkRed,
            textColor: AppColors.background,
          );
        case NavigateToHome():
          UIUtils.hideLoading(context);
          UIUtils.showMessage(
            AppTextConstants.loginSuccess,
            backGroundColor: AppColors.green,
            textColor: AppColors.background,
          );
          context.go(AppRoutesConstants.homeRoute);
      }
    });
  }

  @override
  void didChangeDependencies() {
    textTheme = Theme.of(context).textTheme;
    screenSize = MediaQuery.of(context).size;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppTextConstants.login)),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(
              right: 16.0,
              left: 16.0,
              top: 16.0,
              bottom: 12.0,
            ),
            child: Column(
              children: [
                TextFormField(
                  controller: _emailController,
                  validator: AppValidators.validateEmail,
                  onChanged: (value) {
                    loginCubit.doIntent(
                      ValidateFields(value, _passwordController.text),
                    );
                  },
                  onTapOutside: (_) {
                    FocusManager.instance.primaryFocus?.unfocus();
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: AppTextConstants.email,
                    hintText: AppTextConstants.enterEmail,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 18.0,
                    ),
                  ),
                ),
                24.verticalSpacing,
                TextFormField(
                  controller: _passwordController,
                  validator: AppValidators.validateLoginPassword,
                  keyboardType: TextInputType.text,
                  onChanged: (value) => loginCubit.doIntent(
                    ValidateFields(_emailController.text, value),
                  ),
                  onTapOutside: (_) {
                    FocusManager.instance.primaryFocus?.unfocus();
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                    labelText: AppTextConstants.password,
                    hintText: AppTextConstants.enterPassword,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 18.0,
                    ),
                  ),
                ),
                15.verticalSpacing,
                Row(
                  children: [
                    SizedBox(
                      height: 18,
                      width: 18,
                      child: BlocBuilder<LoginCubit, LoginStates>(
                        builder: (context, state) {
                          return Checkbox(
                            checkColor: AppColors.background,
                            activeColor: AppColors.primary,
                            value: state.rememberMe,
                            onChanged: (_) =>
                                loginCubit.doIntent(RememberMeToggled()),
                          );
                        },
                      ),
                    ),
                    TextButton(
                      child: Text(
                        AppTextConstants.rememberMe,
                        style: textTheme.titleSmall,
                      ),
                      onPressed: () {
                        loginCubit.doIntent(RememberMeToggled());
                      },
                    ),
                    const Spacer(),
                    TextButton(
                      child: Text(
                        AppTextConstants.forgetPasswordHeadLine,
                        style: textTheme.titleSmall!.copyWith(
                          decoration: TextDecoration.underline,
                        ),
                      ),
                      onPressed: () {
                        context.pushNamed(
                          AppRoutesConstants.forgetPasswordRoute,
                        );
                      },
                    ),
                  ],
                ),
                60.verticalSpacing,
                BlocBuilder<LoginCubit, LoginStates>(
                  builder: (context, state) {
                    return ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        fixedSize: Size(screenSize.width, 48),
                      ),
                      child: Text(AppTextConstants.login),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          loginCubit.doIntent(
                            LoginSubmitted(
                              LoginRequestEntity(
                                email: _emailController.text,
                                password: _passwordController.text,
                              ),
                            ),
                          );
                        }
                      },
                    );
                  },
                ),
                16.verticalSpacing,
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    side: BorderSide(color: AppColors.textSecondary),
                    fixedSize: Size(screenSize.width, 48),
                    backgroundColor: Colors.white,
                    foregroundColor: AppColors.textSecondary,
                  ),

                  child: Text(AppTextConstants.guestUser),
                  onPressed: () {
                    context.go(AppRoutesConstants.homeRoute);
                  },
                ),
                16.verticalSpacing,
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(AppTextConstants.dontHaveAccount),
                    TextButton(
                      onPressed: () {
                        // Navigate to Sign Up screen
                        context.pushNamed(AppRoutesConstants.registerRoute);
                      },
                      child: Text(
                        AppTextConstants.signUp,
                        style: textTheme.bodySmall!.copyWith(
                          color: AppColors.primary,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
