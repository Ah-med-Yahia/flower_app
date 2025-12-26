import 'package:online_exam_app/config/base_state/base_state.dart';
import 'package:online_exam_app/features/auth/register/domain/entities/register_entity.dart';

class RegisterStates extends BaseState<RegisterEntity> {
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final String confirmPassword;
  final String phoneNumber;
  final String gender;
  final bool isFormValid;

  RegisterStates({
    super.isLoading = false,
    super.data,
    super.errorMessage,
    this.firstName = '',
    this.lastName = '',
    this.email = '',
    this.password = '',
    this.confirmPassword = '',
    this.phoneNumber = '',
    this.gender = '',
    this.isFormValid = false,
  });

  List<Object?> get props => [
    isLoading,
    data,
    errorMessage,
    firstName,
    lastName,
    email,
    password,
    confirmPassword,
    phoneNumber,
    gender,
    isFormValid,
  ];

  @override
  RegisterStates copyWith({
    RegisterEntity? data,
    bool clearData = false,
    String? errorMessage,
    bool clearError = false,
    bool? isLoading,
    String? firstName,
    String? lastName,
    String? email,
    String? password,
    String? confirmPassword,
    String? phoneNumber,
    String? gender,
    bool? isFormValid,
  }) {
    return RegisterStates(
      isLoading: isLoading ?? this.isLoading,
      data: clearData ? null : (data ?? this.data),
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      gender: gender ?? this.gender,
      isFormValid: isFormValid ?? this.isFormValid,
    );
  }
}
