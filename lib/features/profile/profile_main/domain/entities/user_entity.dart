import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String id;
  final String firstName;
  final String email;
  final String imgAvatarURL;

  const UserEntity({
    required this.id,
    required this.firstName,
    required this.email,
    required this.imgAvatarURL,
  });

  @override
  List<Object?> get props => [id, firstName, email, imgAvatarURL];
}
