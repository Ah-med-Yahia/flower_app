import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/best_seller.dart';

part 'best_seller_dto.g.dart';

@JsonSerializable()
class BestSellerDto {
  @JsonKey(name: "_id")
  String? id;
  @JsonKey(name: "title")
  String? title;
  @JsonKey(name: "slug")
  String? slug;
  @JsonKey(name: "description")
  String? description;
  @JsonKey(name: "imgCover")
  String? imgCover;
  @JsonKey(name: "images")
  List<String>? images;
  @JsonKey(name: "price")
  int? price;
  @JsonKey(name: "priceAfterDiscount")
  int? priceAfterDiscount;
  @JsonKey(name: "quantity")
  int? quantity;
  @JsonKey(name: "category")
  String? category;
  @JsonKey(name: "occasion")
  String? occasion;
  @JsonKey(name: "createdAt")
  DateTime? createdAt;
  @JsonKey(name: "updatedAt")
  DateTime? updatedAt;
  @JsonKey(name: "__v")
  int? v;
  @JsonKey(name: "isSuperAdmin")
  bool? isSuperAdmin;
  @JsonKey(name: "sold")
  int? sold;
  @JsonKey(name: "rateAvg")
  int? rateAvg;
  @JsonKey(name: "rateCount")
  int? rateCount;
  @JsonKey(name: "id")
  String? bestSellerId;
  @JsonKey(name: "discount")
  int? discount;

  BestSellerDto({
    this.id,
    this.title,
    this.slug,
    this.description,
    this.imgCover,
    this.images,
    this.price,
    this.priceAfterDiscount,
    this.quantity,
    this.category,
    this.occasion,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.isSuperAdmin,
    this.sold,
    this.rateAvg,
    this.rateCount,
    this.bestSellerId,
    this.discount,
  });

  factory BestSellerDto.fromJson(Map<String, dynamic> json) =>
      _$BestSellerDtoFromJson(json);

  Map<String, dynamic> toJson() => _$BestSellerDtoToJson(this);

  BestSeller toEntity() {
    return BestSeller(
      id: id ?? '',
      title: title ?? '',
      imgCover: imgCover ?? '',
      price: price ?? 0,
      priceAfterDiscount: priceAfterDiscount ?? 0,
      discount: discount ?? 0,
      quantity: quantity ?? 0,
      sold: sold ?? 0,
      bestSellerId: bestSellerId ?? '',
    );
  }
}
