import 'package:flutter/material.dart';

import '../../../../../../../core/constants/app_text_constants.dart';
import '../../../../../../../core/shared/presentation/widgets/spacing.dart';
import '../../../../../../auth/forget_password/presentation/views/shared_widgets/custom_edit_text_widget.dart';

class EditProfileTextFieldSectionWidget extends StatelessWidget {
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final TextEditingController emailController;
  final TextEditingController phoneController;

  const EditProfileTextFieldSectionWidget({
    super.key,
    required this.firstNameController,
    required this.lastNameController,
    required this.emailController,
    required this.phoneController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // -------- First Name & Last Name --------//
        Row(
          children: [
            Expanded(
              child: CustomEditTextWidget(
                edtTxtController: firstNameController,
                keyboardType: TextInputType.text,
                isEnabled: true,
                labelText: AppTextConstants.firstName,
                hintText: AppTextConstants.enterFirstName,
                focusErrorText: AppTextConstants.firstName,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return AppTextConstants.enterFirstName;
                  }
                  return null;
                },
              ),
            ),
            24.horizontalSpacing,
            Expanded(
              child: CustomEditTextWidget(
                edtTxtController: lastNameController,
                keyboardType: TextInputType.text,
                isEnabled: true,
                labelText: AppTextConstants.lastName,
                hintText: AppTextConstants.enterLastName,
                focusErrorText: AppTextConstants.lastName,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return AppTextConstants.enterLastName;
                  }
                  return null;
                },
              ),
            ),
          ],
        ),
        24.verticalSpacing,
        // -------- Email --------//
        CustomEditTextWidget(
          edtTxtController: emailController,
          keyboardType: TextInputType.emailAddress,
          isEnabled: false,
          labelText: AppTextConstants.email,
          hintText: AppTextConstants.enterEmail,
          focusErrorText: AppTextConstants.emailFocusError,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return AppTextConstants.enterFirstName;
            }
            return null;
          },
        ),
        24.verticalSpacing,
        // -------- Phone Number --------//
        CustomEditTextWidget(
          edtTxtController: phoneController,
          keyboardType: TextInputType.number,
          isEnabled: true,
          labelText: AppTextConstants.phoneNumber,
          hintText: AppTextConstants.enterPhoneNumber,
          focusErrorText: AppTextConstants.phoneNumber,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return AppTextConstants.phoneNumber;
            }
            return null;
          },
        ),
        24.verticalSpacing,
      ],
    );
  }
}
