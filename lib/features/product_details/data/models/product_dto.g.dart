// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductDto _$ProductDtoFromJson(Map<String, dynamic> json) => ProductDto(
  id: json['_id'] as String,
  title: json['title'] as String,
  slug: json['slug'] as String,
  description: json['description'] as String,
  imgCover: json['imgCover'] as String,
  images: (json['images'] as List<dynamic>).map((e) => e as String).toList(),
  price: (json['price'] as num).toDouble(),
  priceAfterDiscount: (json['priceAfterDiscount'] as num).toDouble(),
  quantity: (json['quantity'] as num).toInt(),
  category: json['category'] as String,
  occasion: json['occasion'] as String,
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt: DateTime.parse(json['updatedAt'] as String),
  v: (json['__v'] as num).toInt(),
  isSuperAdmin: json['isSuperAdmin'] as bool,
  sold: (json['sold'] as num).toInt(),
  rateAvg: (json['rateAvg'] as num).toDouble(),
  rateCount: (json['rateCount'] as num).toInt(),
  favoriteId: json['favoriteId'] as String?,
  isInWishlist: json['isInWishlist'] as bool,
);

Map<String, dynamic> _$ProductDtoToJson(ProductDto instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'title': instance.title,
      'slug': instance.slug,
      'description': instance.description,
      'imgCover': instance.imgCover,
      'images': instance.images,
      'price': instance.price,
      'priceAfterDiscount': instance.priceAfterDiscount,
      'quantity': instance.quantity,
      'category': instance.category,
      'occasion': instance.occasion,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      '__v': instance.v,
      'isSuperAdmin': instance.isSuperAdmin,
      'sold': instance.sold,
      'rateAvg': instance.rateAvg,
      'rateCount': instance.rateCount,
      'favoriteId': instance.favoriteId,
      'isInWishlist': instance.isInWishlist,
    };
