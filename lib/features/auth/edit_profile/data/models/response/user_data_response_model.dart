import 'package:json_annotation/json_annotation.dart';

import '../../../../../../core/shared/data/models/user_model.dart';
import '../../../domain/entities/user_data_response_entity.dart';

part 'user_data_response_model.g.dart';

@JsonSerializable()
class UserDataResponseModel {
  @JsonKey(name: 'message')
  String? message;
  @JsonKey(name: 'user')
  UserModel? userModel;

  UserDataResponseModel({this.message, this.userModel});

  factory UserDataResponseModel.fromJson(Map<String, dynamic> json) =>
      _$UserDataResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserDataResponseModelToJson(this);

  UserDataResponseEntity toEntity() => UserDataResponseEntity(
    message: message ?? '',
    userEntity: userModel != null ? userModel!.toEntity() : const UserEntity(),
  );
}
