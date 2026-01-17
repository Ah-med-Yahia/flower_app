import 'package:json_annotation/json_annotation.dart';
import '../../data/models/register_response/user.dart';
part 'register_entity.g.dart';

@JsonSerializable()
class RegisterEntity {
  final String message;
  final User user;
  final String token;

  const RegisterEntity({
    required this.message,
    required this.user,
    required this.token,
  });
  factory RegisterEntity.fromJson(Map<String, dynamic> json) =>
      _$RegisterEntityFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterEntityToJson(this);
}
