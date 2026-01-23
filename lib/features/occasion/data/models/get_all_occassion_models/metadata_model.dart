import 'package:json_annotation/json_annotation.dart';

part 'metadata_model.g.dart';

@JsonSerializable()
class MetadataModel {
  @JsonKey(name: 'currentPage')
  final int currentPage;
  @JsonKey(name: 'limit')
  final int limit;
  @JsonKey(name: 'totalPages')
  final int totalPages;
  @JsonKey(name: 'totalItems')
  final int totalItems;

  MetadataModel({
    required this.currentPage,
    required this.limit,
    required this.totalPages,
    required this.totalItems,
  });

  factory MetadataModel.fromJson(Map<String, dynamic> json) =>
      _$MetadataModelFromJson(json);
  Map<String, dynamic> toJson() => _$MetadataModelToJson(this);
}
