import 'package:json_annotation/json_annotation.dart';
import 'package:flower_app/features/products/occasion/data/models/get_all_occassion_models/metadata_model.dart';
import 'package:flower_app/features/products/occasion/data/models/get_all_occassion_models/occasion_model.dart';
import 'package:flower_app/features/products/occasion/domain/entities/get_all_occasions_list_entity.dart';

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
