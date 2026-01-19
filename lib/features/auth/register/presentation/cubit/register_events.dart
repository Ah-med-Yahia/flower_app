abstract class RegisterEvents {}

class FirstNameChanged extends RegisterEvents {
  final String firstName;
  FirstNameChanged(this.firstName);
}

class LastNameChanged extends RegisterEvents {
  final String lastName;
  LastNameChanged(this.lastName);
}

class EmailChanged extends RegisterEvents {
  final String email;
  EmailChanged(this.email);
}

class PasswordChanged extends RegisterEvents {
  final String password;
  PasswordChanged(this.password);
}

class ConfirmPasswordChanged extends RegisterEvents {
  final String confirmPassword;
  ConfirmPasswordChanged(this.confirmPassword);
}

class PhoneNumberChanged extends RegisterEvents {
  final String phoneNumber;
  PhoneNumberChanged(this.phoneNumber);
}

class GenderChanged extends RegisterEvents {
  final String gender;
  GenderChanged(this.gender);
}

class SignUpButtonPressed extends RegisterEvents {
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final String confirmPassword;
  final String phoneNumber;
  final String gender;

  SignUpButtonPressed({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.confirmPassword,
    required this.phoneNumber,
    required this.gender,
  });
}
