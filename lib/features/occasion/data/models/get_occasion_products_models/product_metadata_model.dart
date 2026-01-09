import 'package:json_annotation/json_annotation.dart';

part 'product_metadata_model.g.dart';

@JsonSerializable()
class ProductMetadataModel {
  final int currentPage;
  final int totalPages;
  final int limit;
  final int totalItems;

  ProductMetadataModel({
    required this.currentPage,
    required this.totalPages,
    required this.limit,
    required this.totalItems,
  });

  factory ProductMetadataModel.fromJson(Map<String, dynamic> json) =>
      _$ProductMetadataModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductMetadataModelToJson(this);
}
