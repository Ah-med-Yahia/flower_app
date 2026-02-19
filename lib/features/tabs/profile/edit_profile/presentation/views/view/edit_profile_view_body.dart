import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../../core/constants/app_routes_constant.dart';
import '../../../../../../../core/constants/app_text_constants.dart';
import '../../../../../../../core/gen/assets.gen.dart';
import '../../../../../../../core/theme/app_colors.dart';
import '../../../../../../../core/shared/presentation/widgets/spacing.dart';
import '../../../../profile_main/domain/entities/user_data_response.dart';
import '../../../../../../auth/forget_password/presentation/views/shared_widgets/custom_edit_text_widget.dart';
import '../../../data/models/request/edit_user_data_request_model.dart';
import '../../../domain/entities/user_data_response_entity.dart';
import '../../view_models/edit_profile_cubit.dart';
import '../../view_models/edit_profile_events.dart';
import '../../view_models/edit_profile_states.dart';
import '../widget/edit_profile_picture_section_widget.dart';
import '../widget/edit_profile_text_field_section_widget.dart';

class EditProfileViewBody extends StatefulWidget {
  final UserDataResponse userData;

  const EditProfileViewBody({super.key, required this.userData});

  @override
  State<EditProfileViewBody> createState() => _EditProfileViewBodyState();
}

class _EditProfileViewBodyState extends State<EditProfileViewBody> {
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late TextEditingController _passwordPlaceholderController;

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController(
      text: widget.userData.user.firstName,
    );
    _lastNameController = TextEditingController(
      text: widget.userData.user.lastName,
    );
    _emailController = TextEditingController(text: widget.userData.user.email);
    _phoneController = TextEditingController(
      text: widget.userData.user.phoneNumber,
    );
    _passwordPlaceholderController = TextEditingController(text: '********');
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordPlaceholderController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppTextConstants.editProfile),
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(Icons.arrow_back_ios_new_outlined),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Assets.images.notification.image(),
          ),
        ],
      ),
      body: BlocListener<EditProfileCubit, EditProfileStates>(
        listener: (context, state) {
          if (state.navigateTo == NavigationAction.changePasswordScreen) {
            context.push(AppRoutesConstants.changePasswordRoute);
          }
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // -------- Picture --------//
              EditProfilePictureSectionWidget(
                pictureURL: widget.userData.user.imgAvatarURL,
              ),
              24.verticalSpacing,
              // -------- FirstName & LastName & Email & Phone --------//
              EditProfileTextFieldSectionWidget(
                firstNameController: _firstNameController,
                lastNameController: _lastNameController,
                emailController: _emailController,
                phoneController: _phoneController,
              ),
              // -------- Password --------//
              CustomEditTextWidget(
                validator: null,
                edtTxtController: _passwordPlaceholderController,
                keyboardType: TextInputType.none,
                isEnabled: true,
                labelText: AppTextConstants.password,
                hintText: AppTextConstants.enterPassword,
                focusErrorText: AppTextConstants.password,
                suffixIcon: TextButton(
                  onPressed: () {
                    context.read<EditProfileCubit>().doIntent(
                      NavigateToChangePasswordEvent(),
                    );
                  },
                  child: Text(AppTextConstants.change),
                ),
              ),
              24.verticalSpacing,
              // -------- Update Button --------//
              BlocBuilder<EditProfileCubit, EditProfileStates>(
                builder: (context, state) {
                  return ElevatedButton(
                    onPressed: state.userDataState.isLoading
                        ? null
                        : () {
                            context.read<EditProfileCubit>().doIntent(
                              UpdateUserDataEvent(
                                requestModel: EditUserDataRequestModel(
                                  firstName: _firstNameController.text,
                                  lastName: _lastNameController.text,
                                  phoneNumber: _phoneController.text,
                                ),
                                currentData: UserDataResponseEntity(
                                  message: widget.userData.message,
                                  userEntity: UserEntity(
                                    firstName: widget.userData.user.firstName,
                                    lastName: widget.userData.user.lastName,
                                    phoneNumber:
                                        widget.userData.user.phoneNumber,
                                    imgAvatarURL:
                                        widget.userData.user.imgAvatarURL,
                                  ),
                                ),
                              ),
                            );
                          },
                    child: state.userDataState.isLoading
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: AppColors.white,
                            ),
                          )
                        : Text(AppTextConstants.update),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
