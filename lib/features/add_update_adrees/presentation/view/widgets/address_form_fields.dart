import 'package:flower_app/core/constants/app_text_constants.dart';
import 'package:flutter/material.dart';

class AddressFormFields extends StatelessWidget {
  final TextEditingController addressController;
  final TextEditingController phoneController;
  final TextEditingController nameController;

  const AddressFormFields({
    super.key,
    required this.addressController,
    required this.phoneController,
    required this.nameController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          controller: addressController,
          decoration: InputDecoration(
            labelText: AppTextConstants.address,
            hintText: AppTextConstants.enterAddress,
          ),
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: phoneController,
          keyboardType: TextInputType.phone,
          decoration: InputDecoration(
            labelText: AppTextConstants.phoneNumber,
            hintText: AppTextConstants.enterPhoneNumber,
          ),
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: nameController,
          decoration: InputDecoration(
            labelText: AppTextConstants.recipientName,
            hintText: AppTextConstants.enterTheRecipientName,
          ),
        ),
      ],
    );
  }
}
