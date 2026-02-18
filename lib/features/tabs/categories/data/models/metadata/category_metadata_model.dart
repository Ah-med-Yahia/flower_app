import 'package:json_annotation/json_annotation.dart';

part 'category_metadata_model.g.dart';

@JsonSerializable()
class CategoryMetadataModel {
  @JsonKey(name: 'currentPage')
  final int? currentPage;
  @JsonKey(name: 'totalPages')
  final int? totalPages;
  @JsonKey(name: 'limit')
  final int? limit;
  @JsonKey(name: 'totalItems')
  final int? totalItems;

  CategoryMetadataModel({
    this.currentPage,
    this.totalPages,
    this.limit,
    this.totalItems,
  });

  factory CategoryMetadataModel.fromJson(Map<String, dynamic> json) =>
      _$CategoryMetadataModelFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryMetadataModelToJson(this);
}
