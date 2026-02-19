import 'package:flower_app/core/shared/data/models/get_products_models/product_model.dart';
import 'package:flower_app/features/home/data/models/category_dto.dart';
import 'package:flower_app/features/home/data/models/occasion_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'home_response_dto.g.dart';

@JsonSerializable(explicitToJson: true)
class HomeResponseDto {
  @JsonKey(name: 'message')
  final String? message;

  @JsonKey(name: 'categories')
  final List<CategoryDto>? categories;

  @JsonKey(name: 'bestSeller')
  final List<ProductModel>? bestSeller;

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
