import 'package:json_annotation/json_annotation.dart';
import 'package:online_exam_app/features/occasion/data/models/get_all_occassion_models/metadata_model.dart';
import 'package:online_exam_app/features/occasion/data/models/get_all_occassion_models/occasion_model.dart';
import 'package:online_exam_app/features/occasion/domain/entities/get_all_occasion_entity.dart';

part 'get_all_occasions_response_model.g.dart';

@JsonSerializable()
class GetAllOccasionsResponseModel {
  final String message;
  final MetadataModel metadata;
  final List<OccasionModel> occasions;

  GetAllOccasionsResponseModel({
    required this.message,
    required this.metadata,
    required this.occasions,
  });

  factory GetAllOccasionsResponseModel.fromJson(Map<String, dynamic> json) =>
      _$GetAllOccasionsResponseModelFromJson(json);
  Map<String, dynamic> toJson() => _$GetAllOccasionsResponseModelToJson(this);

  GetAllOccasionEntity toEntity() {
    return GetAllOccasionEntity(
      occasions: occasions.map((e) => e.toEntity()).toList(),
    );
  }
}
