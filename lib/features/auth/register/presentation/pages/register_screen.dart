import 'package:flower_app/config/di/di.dart';
import 'package:flower_app/core/constants/app_routes_constant.dart';
import 'package:flower_app/core/constants/app_text_constants.dart';
import 'package:flower_app/core/theme/app_colors.dart';
import 'package:flower_app/core/ui_utils/ui_utils.dart';
import 'package:flower_app/features/auth/register/presentation/cubit/register_cubit.dart';
import 'package:flower_app/features/auth/register/presentation/cubit/register_states.dart';
import 'package:flower_app/features/auth/register/presentation/cubit/register_ui_events.dart';
import 'package:flower_app/features/auth/register/presentation/widgets/email_field_widget.dart';
import 'package:flower_app/features/auth/register/presentation/widgets/gender_selector_widget.dart';
import 'package:flower_app/features/auth/register/presentation/widgets/name_field_widget.dart';
import 'package:flower_app/features/auth/register/presentation/widgets/password_field_widget.dart';
import 'package:flower_app/features/auth/register/presentation/widgets/phone_field_widget.dart';
import 'package:flower_app/features/auth/register/presentation/widgets/sign_up_button_widget.dart';
import 'package:flower_app/features/auth/register/presentation/widgets/terms_and_conditions_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  late final RegisterCubit cubit;

  final _firstName = TextEditingController();
  final _lastName = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _confirmPassword = TextEditingController();
  final _phone = TextEditingController();

  @override
  void initState() {
    super.initState();
    cubit = getIt<RegisterCubit>();

    cubit.uiEvents.listen((event) {
      if (!mounted) return;

      switch (event) {
        case ShowRegisterLoading():
          UIUtils.showLoading(context);

        case ShowRegisterError():
          UIUtils.hideLoading(context);
          UIUtils.showMessage(
            event.message,
            backGroundColor: AppColors.darkRed,
            textColor: AppColors.background,
          );

        case NavigateToLogin():
          UIUtils.hideLoading(context);
          UIUtils.showMessage(
            AppTextConstants.accountCreatedSuccessfully,
            backGroundColor: AppColors.darkGreen,
            textColor: AppColors.background,
          );
          context.pushNamed(AppRoutesConstants.loginRoute);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: cubit,
      child: Scaffold(
        appBar: AppBar(
          leading: const BackButton(),
          title: const Text(AppTextConstants.signUp),
          centerTitle: true,
        ),
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                NameFieldsWidget(
                  firstName: _firstName,
                  lastName: _lastName,
                  cubit: cubit,
                ),
                const SizedBox(height: 30),
                EmailFieldWidget(controller: _email, cubit: cubit),
                const SizedBox(height: 30),
                PasswordFieldsWidget(
                  password: _password,
                  confirmPassword: _confirmPassword,
                  cubit: cubit,
                ),
                const SizedBox(height: 30),
                PhoneFieldWidget(controller: _phone, cubit: cubit),
                const SizedBox(height: 30),
                GenderSelectorWidget(cubit: cubit),
                const SizedBox(height: 12),
                TermsAndConditionsWidget(),
                const SizedBox(height: 30),
                BlocBuilder<RegisterCubit, RegisterStates>(
                  builder: (_, state) {
                    return SignUpButtonWidget(
                      cubit: cubit,
                      formKey: _formKey,
                      state: state,
                      values: {
                        AppTextConstants.firstName: _firstName.text,
                        AppTextConstants.lastName: _lastName.text,
                        AppTextConstants.email: _email.text,
                        AppTextConstants.password: _password.text,
                        AppTextConstants.confirmPassword: _confirmPassword.text,
                        AppTextConstants.phoneNumber: _phone.text,
                      },
                    );
                  },
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
    _firstName.dispose();
    _lastName.dispose();
    _email.dispose();
    _password.dispose();
    _confirmPassword.dispose();
    _phone.dispose();
    cubit.close();
    super.dispose();
  }
}
