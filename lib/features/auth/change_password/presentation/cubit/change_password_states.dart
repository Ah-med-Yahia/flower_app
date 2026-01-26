part of 'change_password_cubit.dart';

class ChangePasswordStates extends BaseState<void> {
  final String currentPassword;
  final String newPassword;
  final String confirmPassword;
  final bool isValidForm;

  const ChangePasswordStates({
    super.errorMessage,
    super.isLoading,
    this.currentPassword = '',
    this.newPassword = '',
    this.confirmPassword = '',
    this.isValidForm = false,
  });

  @override
  List<Object?> get props => [
    errorMessage,
    isLoading,
    currentPassword,
    newPassword,
    confirmPassword,
    isValidForm,
  ];

  @override
  ChangePasswordStates copyWith({
    data,
    String? errorMessage,
    bool? isLoading,
    String? currentPassword,
    String? newPassword,
    String? confirmPassword,
    bool? isvalidForm,
  }) {
    return ChangePasswordStates(
      errorMessage: errorMessage ?? this.errorMessage,
      isLoading: isLoading ?? this.isLoading,
      currentPassword: currentPassword ?? this.currentPassword,
      newPassword: newPassword ?? this.newPassword,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      isValidForm: isvalidForm ?? this.isValidForm,
    );
  }
}
