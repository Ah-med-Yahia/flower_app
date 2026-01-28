import 'package:json_annotation/json_annotation.dart';

import '../../../domain/entities/get_all_occasions_list_entity.dart';
import 'metadata_model.dart';
import 'occasion_model.dart';

part 'get_all_occasions_response_model.g.dart';

@JsonSerializable()
class GetAllOccasionsResponseModel {
  @JsonKey(name: 'message')
  final String? message;

  @JsonKey(name: 'metadata')
  final MetadataModel? metadata;

  @JsonKey(name: 'occasions', defaultValue: [])
  final List<OccasionModel> occasions;

  GetAllOccasionsResponseModel({
    this.message,
    this.metadata,
    required this.occasions,
  });

  factory GetAllOccasionsResponseModel.fromJson(Map<String, dynamic> json) =>
      _$GetAllOccasionsResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$GetAllOccasionsResponseModelToJson(this);

  GetOccasionListEntity toEntity() {
    return GetOccasionListEntity(
      occasions: occasions.map((e) => e.toEntity()).toList(),
    );
  }
}
