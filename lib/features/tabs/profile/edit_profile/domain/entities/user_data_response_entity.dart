import 'package:equatable/equatable.dart';

class UserDataResponseEntity extends Equatable {
  final String message;
  final UserEntity userEntity;

  const UserDataResponseEntity({
    this.message = '',
    this.userEntity = const UserEntity(),
  });

  @override
  List<Object?> get props => [message, userEntity];
}

class UserEntity extends Equatable {
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String? imgAvatarURL;
  final String? email;

  const UserEntity({
    this.firstName = '',
    this.lastName = '',
    this.phoneNumber = '',
    this.imgAvatarURL = '',
    this.email = '',
  });

  @override
  List<Object?> get props => [
    firstName,
    lastName,
    phoneNumber,
    imgAvatarURL,
    email,
  ];
}
