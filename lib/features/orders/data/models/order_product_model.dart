import 'package:flower_app/features/orders/domain/entities/order_product_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'order_product_model.g.dart';

@JsonSerializable()
class OrderProductModel {
  @JsonKey(name: '_id')
  final String? id;

  @JsonKey(name: 'title')
  final String? title;

  @JsonKey(name: 'slug')
  final String? slug;

  @JsonKey(name: 'description')
  final String? description;

  @JsonKey(name: 'imgCover')
  final String? imgCover;

  @JsonKey(name: 'images')
  final List<String>? images;

  @JsonKey(name: 'price')
  final int? price;

  @JsonKey(name: 'priceAfterDiscount')
  final int? priceAfterDiscount;

  @JsonKey(name: 'quantity')
  final int? quantity;

  @JsonKey(name: 'rateAvg')
  final int? rateAvg;

  @JsonKey(name: 'rateCount')
  final int? rateCount;

  OrderProductModel({
    this.id,
    this.title,
    this.slug,
    this.description,
    this.imgCover,
    this.images,
    this.price,
    this.priceAfterDiscount,
    this.quantity,
    this.rateAvg,
    this.rateCount,
  });

  factory OrderProductModel.fromJson(Map<String, dynamic> json) =>
      _$OrderProductModelFromJson(json);

  Map<String, dynamic> toJson() => _$OrderProductModelToJson(this);

  OrderProductEntity toEntity() {
    return OrderProductEntity(
      id: id ?? '',
      title: title ?? '',
      imgCover: imgCover ?? '',
      price: price ?? 0,
      priceAfterDiscount: priceAfterDiscount ?? 0,
    );
  }
}
