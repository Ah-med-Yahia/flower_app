import 'package:equatable/equatable.dart';

import 'user_entity.dart';

class UserDataResponse extends Equatable {
  final String message;
  final UserEntity user;

  const UserDataResponse(this.message, this.user);

  @override
  List<Object?> get props => [message, user];
}
