import 'package:json_annotation/json_annotation.dart';

part 'edit_user_data_request_model.g.dart';

@JsonSerializable()
class EditUserDataRequestModel {
  @JsonKey(name: 'firstName')
  final String? firstName;
  @JsonKey(name: 'lastName')
  final String? lastName;
  @JsonKey(name: 'phone')
  final String? phoneNumber;

  const EditUserDataRequestModel({
    this.firstName,
    this.lastName,
    this.phoneNumber,
  });

  factory EditUserDataRequestModel.fromJson(Map<String, dynamic> json) =>
      _$EditUserDataRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$EditUserDataRequestModelToJson(this);
}
