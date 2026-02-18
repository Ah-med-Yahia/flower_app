import 'package:flower_app/config/di/di.dart';
import 'package:flower_app/core/constants/app_routes_constant.dart';
import 'package:flower_app/core/constants/app_text_constants.dart';
import 'package:flower_app/core/theme/app_colors.dart';
import 'package:flower_app/core/ui_utils/ui_utils.dart';
import 'package:flower_app/core/shared/presentation/widgets/spacing.dart';
import 'package:flower_app/features/auth/login/domain/entities/login_request_entity.dart';
import 'package:flower_app/features/auth/login/presentation/cubit/login_cubit.dart';
import 'package:flower_app/features/auth/login/presentation/cubit/login_intents.dart';
import 'package:flower_app/features/auth/login/presentation/cubit/login_state.dart';
import 'package:flower_app/features/auth/login/presentation/cubit/login_ui_events.dart';
import 'package:flower_app/features/auth/login/presentation/widgets/login_fields_widget.dart';
import 'package:flower_app/features/auth/login/presentation/widgets/login_footer.dart';
import 'package:flower_app/features/auth/login/presentation/widgets/remeber_me_widget.dart';
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
    loginCubit = getIt<LoginCubit>();
    loginCubit.uiEvents.listen((event) {
      if (!mounted) return;
      switch (event) {
        case ShowLoading():
          UIUtils.showLoading(context);
        case ShowErrorMessage():
          _handleError(event.message);
        case NavigateToHome():
          _handleNavigateToHome();
      }
    });
  }

  void _handleError(String message) {
    UIUtils.hideLoading(context);
    UIUtils.showMessage(
      message,
      backGroundColor: AppColors.darkRed,
      textColor: AppColors.background,
    );
  }

  void _handleNavigateToHome() {
    UIUtils.hideLoading(context);
    UIUtils.showMessage(
      AppTextConstants.loginSuccess,
      backGroundColor: AppColors.green,
      textColor: AppColors.background,
    );
    context.go(AppRoutesConstants.homeRoute);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    textTheme = Theme.of(context).textTheme;
    screenSize = MediaQuery.of(context).size;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => loginCubit,
      child: Scaffold(
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
                  LoginFieldsWidget(
                    emailController: _emailController,
                    passwordController: _passwordController,
                    loginCubit: loginCubit,
                  ),
                  15.verticalSpacing,
                  Row(
                    children: [
                      const RemeberMeWidget(),
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
                      side: const BorderSide(color: AppColors.textSecondary),
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
                  const LoginFooter(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
