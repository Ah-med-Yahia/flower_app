import 'package:json_annotation/json_annotation.dart';

part 'home_screen_product_dto.g.dart';

@JsonSerializable(explicitToJson: true)
class HomeScreenProductDto {
  @JsonKey(name: '_id')
  final String id;

  @JsonKey(name: 'title')
  final String title;

  @JsonKey(name: 'slug')
  final String slug;

  @JsonKey(name: 'description')
  final String description;

  @JsonKey(name: 'imgCover')
  final String imgCover;

  @JsonKey(name: 'images')
  final List<String> images;

  @JsonKey(name: 'price')
  final double price;

  @JsonKey(name: 'priceAfterDiscount')
  final double priceAfterDiscount;

  @JsonKey(name: 'discount')
  final int? discount;

  @JsonKey(name: 'quantity')
  final int quantity;

  @JsonKey(name: 'category')
  final String category;

  @JsonKey(name: 'occasion')
  final String occasion;

  @JsonKey(name: 'createdAt')
  final DateTime createdAt;

  @JsonKey(name: 'updatedAt')
  final DateTime updatedAt;

  @JsonKey(name: '__v')
  final int v;

  @JsonKey(name: 'isSuperAdmin')
  final bool? isSuperAdmin;

  @JsonKey(name: 'sold')
  final int? sold;

  @JsonKey(name: 'rateAvg')
  final double rateAvg;

  @JsonKey(name: 'rateCount')
  final int rateCount;

  HomeScreenProductDto({
    required this.id,
    required this.title,
    required this.slug,
    required this.description,
    required this.imgCover,
    required this.images,
    required this.price,
    required this.priceAfterDiscount,
    this.discount,
    required this.quantity,
    required this.category,
    required this.occasion,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.isSuperAdmin,
    this.sold,
    required this.rateAvg,
    required this.rateCount,
  });

  factory HomeScreenProductDto.fromJson(Map<String, dynamic> json) =>
      _$HomeScreenProductDtoFromJson(json);

  Map<String, dynamic> toJson() => _$HomeScreenProductDtoToJson(this);
}
