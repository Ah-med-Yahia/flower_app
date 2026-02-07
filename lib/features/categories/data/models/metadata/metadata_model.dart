import 'package:json_annotation/json_annotation.dart';

part 'metadata_model.g.dart';

@JsonSerializable()
class MetadataModel {
  @JsonKey(name: 'currentPage')
  final int? currentPage;
  @JsonKey(name: 'totalPages')
  final int? totalPages;
  @JsonKey(name: 'limit')
  final int? limit;
  @JsonKey(name: 'totalItems')
  final int? totalItems;

  MetadataModel({
    this.currentPage,
    this.totalPages,
    this.limit,
    this.totalItems,
  });

  factory MetadataModel.fromJson(Map<String, dynamic> json) =>
      _$MetadataModelFromJson(json);

  Map<String, dynamic> toJson() => _$MetadataModelToJson(this);
}
