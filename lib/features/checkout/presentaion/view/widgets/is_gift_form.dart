import 'package:flower_app/core/constants/app_text_constants.dart';
import 'package:flower_app/core/validators/app_validators.dart';
import 'package:flower_app/features/checkout/presentaion/cubit/checkout_cubit.dart';
import 'package:flower_app/features/checkout/presentaion/cubit/checkout_intents.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class IsGiftForm extends StatefulWidget {
  const IsGiftForm({super.key});

  @override
  State<IsGiftForm> createState() => _IsGiftFormState();
}

class _IsGiftFormState extends State<IsGiftForm> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _phoneController;

  @override
  void initState() {
    super.initState();
    final cubit = context.read<CheckoutCubit>();
    _nameController = TextEditingController(text: cubit.state.giftName);
    _phoneController = TextEditingController(text: cubit.state.giftPhone);

    _nameController.addListener(() {
      cubit.doIntent(UpdateGiftNameIntent(_nameController.text));
    });
    _phoneController.addListener(() {
      cubit.doIntent(UpdateGiftPhoneIntent(_phoneController.text));
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Column(
          children: [
            TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              controller: _nameController,
              validator: AppValidators.validateRequired,
              decoration: InputDecoration(
                labelText: AppTextConstants.name,
                hintText: AppTextConstants.enterName,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onTapOutside: (event) =>
                  FocusManager.instance.primaryFocus?.unfocus(),
            ),
            const SizedBox(height: 24),
            TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              controller: _phoneController,
              validator: AppValidators.validatePhoneNumber,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                labelText: AppTextConstants.phoneNumber,
                hintText: AppTextConstants.enterPhoneNumber,
              ),
              onTapOutside: (event) =>
                  FocusManager.instance.primaryFocus?.unfocus(),
            ),
          ],
        ),
      ),
    );
  }
}
