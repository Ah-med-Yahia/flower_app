part of 'change_password_cubit.dart';

class ChangePasswordStates extends BaseState<ChangePasswordResponseEntity> {
  final String oldPassword;
  final String newPassword;
  final String confirmPassword;
  final bool isvalidForm;

  const ChangePasswordStates({
    super.data,
    super.errorMessage,
    super.isLoading,
    this.oldPassword = '',
    this.newPassword = '',
    this.confirmPassword = '',
    this.isvalidForm = false,
  });

  @override
  List<Object?> get props => [
    data,
    errorMessage,
    isLoading,
    oldPassword,
    newPassword,
    confirmPassword,
    isvalidForm,
  ];

  @override
  ChangePasswordStates copyWith({
    ChangePasswordResponseEntity? data,
    String? errorMessage,
    bool? isLoading,
    String? oldPassword,
    String? newPassword,
    String? confirmPassword,
    bool? isvalidForm,
  }) {
    return ChangePasswordStates(
      data: data ?? this.data,
      errorMessage: errorMessage ?? this.errorMessage,
      isLoading: isLoading ?? this.isLoading,
      oldPassword: oldPassword ?? this.oldPassword,
      newPassword: newPassword ?? this.newPassword,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      isvalidForm: isvalidForm ?? this.isvalidForm,
    );
  }
}
