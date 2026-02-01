import 'package:flower_app/features/checkout/domain/entities/credit_order_entity/icon_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'icon_model.g.dart';

@JsonSerializable()
class IconModel {
  @JsonKey(name: 'file')
  final String? file;
  @JsonKey(name: 'type')
  final String? type;

  const IconModel({this.file, this.type});

  factory IconModel.fromJson(Map<String, dynamic> json) =>
      IconModel(file: json['file'] as String?, type: json['type'] as String?);

  Map<String, dynamic> toJson() => {'file': file, 'type': type};

  IconEntity toEntity() {
    return IconEntity(file: file, type: type);
  }
}
