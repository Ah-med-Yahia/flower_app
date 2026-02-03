import 'package:json_annotation/json_annotation.dart';

part 'upload_image_response_model.g.dart';

@JsonSerializable()
class UploadImageResponseModel {
  @JsonKey(name: 'message')
  final String? message;

  const UploadImageResponseModel({this.message});

  factory UploadImageResponseModel.fromJson(Map<String, dynamic> json) {
    return _$UploadImageResponseModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$UploadImageResponseModelToJson(this);
  }
}
