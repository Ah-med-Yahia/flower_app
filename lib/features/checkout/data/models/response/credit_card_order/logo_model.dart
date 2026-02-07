import 'package:flower_app/features/checkout/domain/entities/credit_order_entity/logo_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'logo_model.g.dart';

@JsonSerializable()
class LogoModel {
  @JsonKey(name: 'file')
  final String? file;
  @JsonKey(name: 'type')
  final String? type;

  const LogoModel({this.file, this.type});

  factory LogoModel.fromJson(Map<String, dynamic> json) =>
      LogoModel(file: json['file'] as String?, type: json['type'] as String?);

  Map<String, dynamic> toJson() => {'file': file, 'type': type};

  LogoEntity toEntity() {
    return LogoEntity(file: file, type: type);
  }
}
