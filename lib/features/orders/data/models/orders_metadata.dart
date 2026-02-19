import 'package:json_annotation/json_annotation.dart';

part 'orders_metadata.g.dart';

@JsonSerializable()
class OrdersMetadata {
  @JsonKey(name: 'currentPage')
  final int? currentPage;

  @JsonKey(name: 'totalPages')
  final int? totalPages;

  @JsonKey(name: 'limit')
  final int? limit;

  @JsonKey(name: 'totalItems')
  final int? totalItems;

  OrdersMetadata({
    this.currentPage,
    this.totalPages,
    this.limit,
    this.totalItems,
  });

  factory OrdersMetadata.fromJson(Map<String, dynamic> json) =>
      _$OrdersMetadataFromJson(json);

  Map<String, dynamic> toJson() => _$OrdersMetadataToJson(this);
}
