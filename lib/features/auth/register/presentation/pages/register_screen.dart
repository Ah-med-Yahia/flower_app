import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_exam_app/config/di/di.dart';
import 'package:online_exam_app/core/constants/app_text_constants.dart';
import 'package:online_exam_app/core/theme/app_colors.dart';
import 'package:online_exam_app/core/validators/app_validators.dart';
import 'package:online_exam_app/core/widgets/ui_utils.dart';
import 'package:online_exam_app/features/auth/register/presentation/cubit/register_cubit.dart';
import 'package:online_exam_app/features/auth/register/presentation/cubit/register_events.dart';
import 'package:online_exam_app/features/auth/register/presentation/cubit/register_states.dart';
import 'package:online_exam_app/features/auth/register/presentation/cubit/register_ui_events.dart';

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

        case NavigateTologin():
          UIUtils.hideLoading(context);
          UIUtils.showMessage(
            "كانك روحت للوجين لحد منميرج",
            backGroundColor: AppColors.darkGreen,
            textColor: AppColors.background,
          );
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
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _firstName,
                        decoration: const InputDecoration(
                          labelText: AppTextConstants.firstName,
                          hintText: AppTextConstants.enterFirstName,
                        ),
                        validator: (value) =>
                            AppValidators.validateRequired(value),
                        onChanged: (v) => cubit.doIntent(FirstNameChanged(v)),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: TextFormField(
                        controller: _lastName,
                        decoration: const InputDecoration(
                          labelText: AppTextConstants.lastName,
                          hintText: AppTextConstants.enterLastName,
                        ),
                        validator: (value) =>
                            AppValidators.validateRequired(value),
                        onChanged: (v) => cubit.doIntent(LastNameChanged(v)),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 30),

                TextFormField(
                  controller: _email,
                  decoration: const InputDecoration(
                    labelText: AppTextConstants.email,
                    hintText: AppTextConstants.enterEmail,
                  ),
                  validator: (value) => value.validateEmail,
                  onChanged: (v) => cubit.doIntent(EmailChanged(v)),
                ),

                const SizedBox(height: 30),

                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _password,
                        obscureText: true,
                        decoration: const InputDecoration(
                          labelText: AppTextConstants.password,
                          hintText: AppTextConstants.enterPassword,
                        ),
                        validator: (value) => value.validatePassword,
                        onChanged: (v) => cubit.doIntent(PasswordChanged(v)),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: TextFormField(
                        controller: _confirmPassword,
                        obscureText: true,
                        decoration: const InputDecoration(
                          labelText: AppTextConstants.confirmPassword,
                          hintText: AppTextConstants.confirmPassword,
                        ),
                        validator: (v) => v.validateMatch(_password.text),
                        onChanged: (v) =>
                            cubit.doIntent(ConfirmPasswordChanged(v)),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 30),

                TextFormField(
                  controller: _phone,
                  decoration: const InputDecoration(
                    labelText: AppTextConstants.phoneNumber,
                    hintText: AppTextConstants.enterPhoneNumber,
                  ),
                  validator: AppValidators.validatePhoneNumber,
                  onChanged: (v) => cubit.doIntent(PhoneNumberChanged(v)),
                ),

                const SizedBox(height: 30),

                BlocBuilder<RegisterCubit, RegisterStates>(
                  builder: (_, state) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RadioGroup<String>(
                          groupValue: state.gender.isEmpty
                              ? null
                              : state.gender,
                          onChanged: (value) {
                            if (value != null) {
                              cubit.doIntent(GenderChanged(value));
                            }
                          },
                          child: Row(
                            children: [
                              Text(
                                AppTextConstants.gender,
                                style: const TextStyle(
                                  fontSize: 20,
                                  color: AppColors.textSecondary,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(width: 20),
                              InkWell(
                                borderRadius: BorderRadius.circular(8),
                                onTap: () {
                                  cubit.doIntent(GenderChanged(AppTextConstants.female));
                                },
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 4,
                                  ),
                                  child: Row(
                                    children: [
                                      Radio<String>(value: AppTextConstants.female),
                                      SizedBox(width: 4),
                                      Text(
                                        AppTextConstants.female,
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: AppColors.textPrimary,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                              const SizedBox(width: 24),

                              InkWell(
                                borderRadius: BorderRadius.circular(8),
                                onTap: () {
                                  cubit.doIntent(GenderChanged(AppTextConstants.male));
                                },
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 4,
                                  ),
                                  child: Row(
                                    children: [
                                      Radio<String>(value: AppTextConstants.gender),
                                      SizedBox(width: 4),
                                      Text(
                                        AppTextConstants.male,
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: AppColors.textPrimary,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 12),

                        Text.rich(
                          TextSpan(
                            text: AppTextConstants.creatingAccountAgreement
                                .replaceAll(
                                  AppTextConstants.termsAndConditions,
                                  '',
                                ),
                            style: const TextStyle(
                              fontSize: 13,
                              color: AppColors.textSecondary,
                              fontWeight: FontWeight.bold,
                            ),
                            children: [
                              TextSpan(
                                text: AppTextConstants.termsAndConditions,
                                style: const TextStyle(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline,
                                ),
                                
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),

                const SizedBox(height: 40),

                BlocBuilder<RegisterCubit, RegisterStates>(
                  builder: (_, state) {
                    return SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        onPressed: state.isFormValid
                            ? () {
                                if (_formKey.currentState!.validate()) {
                                  cubit.doIntent(
                                    SignUpButtonPressed(
                                      firstName: _firstName.text,
                                      lastName: _lastName.text,
                                      email: _email.text,
                                      password: _password.text,
                                      confirmPassword: _confirmPassword.text,
                                      phoneNumber: _phone.text,
                                      gender: state.gender,
                                    ),
                                  );
                                }
                              }
                            : null,
                        child: state.isFormValid
                            ? Text(
                                AppTextConstants.signUp,
                                style: TextStyle(color: AppColors.lightPink),
                              )
                            : Text(
                                AppTextConstants.signUp,
                                style: TextStyle(
                                  color: AppColors.textSecondary,
                                ),
                              ),
                      ),
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
