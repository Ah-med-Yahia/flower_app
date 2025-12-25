import 'package:flutter/material.dart';

class CustomEditTextWidget extends StatelessWidget {
  const CustomEditTextWidget({
    super.key,
    required this.edtTxtController,
    required this.keyboardType,
    required this.isEnabled,
    required this.labelText,
    required this.hintText,
    required this.focusErrorText,
    required this.validator,
  });

  final TextEditingController edtTxtController;
  final TextInputType keyboardType;
  final bool isEnabled;
  final String labelText;
  final String hintText;
  final String focusErrorText;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: edtTxtController,
      keyboardType: keyboardType,
      enabled: isEnabled,
      autocorrect: false,
      autofocus: true,
      enableSuggestions: false,
      maxLines: 1,

      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
      ),
      validator: validator
    );
  }
}
