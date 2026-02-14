import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'city_model.g.dart';

@JsonSerializable(explicitToJson: true)
class CityModel extends Equatable {
  @JsonKey(name: 'id')
  final String id;

  @JsonKey(name: 'governorate_id')
  final String governorateId;

  @JsonKey(name: 'city_name_ar')
  final String cityNameAr;

  @JsonKey(name: 'city_name_en')
  final String cityNameEn;

  const CityModel({
    required this.id,
    required this.governorateId,
    required this.cityNameAr,
    required this.cityNameEn,
  });

  factory CityModel.fromJson(Map<String, dynamic> json) =>
      _$CityModelFromJson(json);

  Map<String, dynamic> toJson() => _$CityModelToJson(this);

  @override
  List<Object?> get props => [id, governorateId, cityNameAr, cityNameEn];
}
