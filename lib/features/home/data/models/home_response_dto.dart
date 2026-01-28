import 'package:json_annotation/json_annotation.dart';

import 'category_dto.dart';
import 'home_screen_product_dto.dart';
import 'occasion_dto.dart';

part 'home_response_dto.g.dart';

@JsonSerializable(explicitToJson: true)
class HomeResponseDto {
  @JsonKey(name: 'message')
  final String? message;

  @JsonKey(name: 'categories')
  final List<CategoryDto>? categories;

  @JsonKey(name: 'bestSeller')
  final List<HomeScreenProductDto>? bestSeller;

  @JsonKey(name: 'occasions')
  final List<OccasionDto>? occasions;

  HomeResponseDto({
    required this.message,
    required this.categories,
    required this.bestSeller,
    required this.occasions,
  });

  factory HomeResponseDto.fromJson(Map<String, dynamic> json) =>
      _$HomeResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$HomeResponseDtoToJson(this);
}
