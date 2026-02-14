import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'state_model.g.dart';

@JsonSerializable(explicitToJson: true)
class StateModel extends Equatable {
  @JsonKey(name: 'id')
  final String id;

  @JsonKey(name: 'governorate_name_ar')
  final String governorateNameAr;

  @JsonKey(name: 'governorate_name_en')
  final String governorateNameEn;

  const StateModel({
    required this.id,
    required this.governorateNameAr,
    required this.governorateNameEn,
  });

  factory StateModel.fromJson(Map<String, dynamic> json) =>
      _$StateModelFromJson(json);

  Map<String, dynamic> toJson() => _$StateModelToJson(this);

  @override
  List<Object?> get props => [id, governorateNameAr, governorateNameEn];
}
