import 'package:json_annotation/json_annotation.dart';
import 'package:online_exam_app/features/occasion/data/models/get_all_occassion_models/metadata_model.dart';
import 'package:online_exam_app/features/occasion/data/models/get_all_occassion_models/occasion_model.dart';
import 'package:online_exam_app/features/occasion/domain/entities/get_all_occasion_entity.dart';

part 'get_all_occasions_response.g.dart';

@JsonSerializable()
class GetAllOccasionsResponse {
  final String message;
  final MetadataModel metadata;
  final List<OccasionModel> occasions;

  GetAllOccasionsResponse({
    required this.message,
    required this.metadata,
    required this.occasions,
  });

  factory GetAllOccasionsResponse.fromJson(Map<String, dynamic> json) =>
      _$GetAllOccasionsResponseFromJson(json);
  Map<String, dynamic> toJson() => _$GetAllOccasionsResponseToJson(this);

  GetAllOccasionEntity toEntity() {
    return GetAllOccasionEntity(
      occasions: occasions.map((e) => e.toEntity()).toList(),
    );
  }
}
