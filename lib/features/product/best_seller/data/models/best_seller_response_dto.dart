import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/best_seller_response.dart';
import '../../domain/entities/pagination_meta_data.dart';
import 'best_seller_dto.dart';

part 'best_seller_response_dto.g.dart';

@JsonSerializable()
class BestSellerResponseDto {
  @JsonKey(name: "message")
  String? message;
  @JsonKey(name: "bestSeller")
  List<BestSellerDto>? bestSellerDto;

  BestSellerResponseDto({this.message, this.bestSellerDto});

  factory BestSellerResponseDto.fromJson(Map<String, dynamic> json) =>
      _$BestSellerResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$BestSellerResponseDtoToJson(this);

  BestSellerResponse toEntity({int currentPage = 1, int itemsPerPage = 10}) {
    final items = bestSellerDto?.map((dto) => dto.toEntity()).toList() ?? [];
    final totalItems = items.length;
    final totalPages = (totalItems / itemsPerPage).ceil(); // 75 / 10 = 7.5 => 8

    return BestSellerResponse(
      message: message ?? '',
      bestSeller: items,
      paginationMetadata: PaginationMetadata(
        currentPage: currentPage,
        numberOfPages: totalPages,
        limit: itemsPerPage,
        total: totalItems,
      ),
    );
  }
}
