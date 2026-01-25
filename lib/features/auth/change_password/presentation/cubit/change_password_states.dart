part of 'change_password_cubit.dart';

class ChangePasswordStates extends BaseState<void> {
  final String oldPassword;
  final String newPassword;
  final String confirmPassword;
  final bool isvalidForm;

  const ChangePasswordStates({
    super.errorMessage,
    super.isLoading,
    this.oldPassword = '',
    this.newPassword = '',
    this.confirmPassword = '',
    this.isvalidForm = false,
  });

  @override
  List<Object?> get props => [
    errorMessage,
    isLoading,
    oldPassword,
    newPassword,
    confirmPassword,
    isvalidForm,
  ];

  @override
  ChangePasswordStates copyWith({
     data,
    String? errorMessage,
    bool? isLoading,
    String? oldPassword,
    String? newPassword,
    String? confirmPassword,
    bool? isvalidForm,
  }) {
    return ChangePasswordStates(
      errorMessage: errorMessage ?? this.errorMessage,
      isLoading: isLoading ?? this.isLoading,
      oldPassword: oldPassword ?? this.oldPassword,
      newPassword: newPassword ?? this.newPassword,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      isvalidForm: isvalidForm ?? this.isvalidForm,
    );
  }
}
