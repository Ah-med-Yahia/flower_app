import 'package:flower_app/core/gen/assets.gen.dart';
import 'package:flower_app/core/theme/app_colors.dart';
import 'package:flower_app/core/validators/app_validators.dart';
import 'package:flutter/material.dart';

import '../../../../../core/constants/app_text_constants.dart';
import '../widgets/select_gender_widger.dart';

class EditProfileViewBodyScreen extends StatefulWidget {
  const EditProfileViewBodyScreen({super.key});

  @override
  State<EditProfileViewBodyScreen> createState() =>
      _EditProfileViewBodyScreenState();
}

class _EditProfileViewBodyScreenState extends State<EditProfileViewBodyScreen> {
  late final TextEditingController _firstName;
  late final TextEditingController _lastName;
  late final TextEditingController _email;
  late final TextEditingController _phone;
  late final GlobalKey<FormState> _formKey;
  late final TextEditingController _password;
  String selectedGender = AppTextConstants.female; // default
  @override
  void initState() {
    _formKey = GlobalKey<FormState>();

    _firstName = TextEditingController(text: "Ahmed");
    _lastName = TextEditingController(text: "Radwan");
    _email = TextEditingController(text: "ahmed.radwan@example.com");
    _password = TextEditingController(text: "********");

    _phone = TextEditingController(text: "123-456-7890");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
          child: Stack(
            alignment: Alignment.bottomRight,
            children: [
              CircleAvatar(
                radius: 60,
                backgroundImage: AssetImage(Assets.images.circleAvatar.path),
              ),
              FloatingActionButton(
                mini: true,

                backgroundColor: AppColors.lightPink,
                onPressed: () {
                  print("object");
                },
                child: Icon(
                  Icons.camera_alt_outlined,
                  color: AppColors.darkGray,
                ),
              ),
            ],
          ),
        ),
        Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              spacing: 24,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _firstName,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        decoration: const InputDecoration(
                          labelText: AppTextConstants.firstName,
                          hintText: AppTextConstants.enterFirstName,
                        ),
                        validator: AppValidators.validateRequired,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: TextFormField(
                        controller: _lastName,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        decoration: const InputDecoration(
                          labelText: AppTextConstants.lastName,
                          hintText: AppTextConstants.enterLastName,
                        ),
                        validator: AppValidators.validateRequired,
                      ),
                    ),
                  ],
                ),
                TextFormField(
                  controller: _email,
                  validator: AppValidators.validateEmail,
                  decoration: const InputDecoration(
                    labelText: AppTextConstants.email,
                    hintText: AppTextConstants.enterEmail,
                  ),
                ),

                TextFormField(
                  controller: _phone,
                  validator: AppValidators.validatePhoneNumber,
                  decoration: InputDecoration(
                    labelText: AppTextConstants.phoneNumber,
                    hintText: AppTextConstants.enterPhoneNumber,
                  ),
                ),
                TextFormField(
                  validator: AppValidators.validatePassword,
                  controller: _password,
                  obscureText: true,
                  readOnly: true,
                  obscuringCharacter: "*",

                  decoration: InputDecoration(
                    labelText: AppTextConstants.password,
                    contentPadding: EdgeInsets.all(10),
                    suffix: TextButton(
                      onPressed: () {},

                      child: Text(
                        AppTextConstants.change,
                        style: TextStyle(
                          color: AppColors.primary,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
                CustomGenderSelected(
                  selectedGender: selectedGender,
                  onChanged: (value) {
                    setState(() {
                      selectedGender = value!;
                    });
                  },
                ),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(50),
                  ),
                  child: Text(
                    AppTextConstants.updateProfile,
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: AppColors.background,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _firstName.dispose();
    _lastName.dispose();
    _email.dispose();
    _phone.dispose();
    _password.dispose();

    super.dispose();
  }
}
