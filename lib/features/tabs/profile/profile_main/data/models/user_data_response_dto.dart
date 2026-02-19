import 'package:json_annotation/json_annotation.dart';

import 'user_dto.dart';

part 'user_data_response_dto.g.dart';

@JsonSerializable()
class UserDataResponseDto {
  @JsonKey(name: 'message')
  String? message;
  @JsonKey(name: 'user')
  UserDto? user;

  UserDataResponseDto({this.message, this.user});

  factory UserDataResponseDto.fromJson(Map<String, dynamic> json) =>
      _$UserDataResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$UserDataResponseDtoToJson(this);
}
