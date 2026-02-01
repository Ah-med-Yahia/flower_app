import 'package:flower_app/features/home/domain/entities/product_entity.dart';
import 'package:json_annotation/json_annotation.dart';
part 'product_model.g.dart';

@JsonSerializable()
class ProductModel {
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
  @JsonKey(name: 'category')
  final String? category;
  @JsonKey(name: 'occasion')
  final String? occasion;
  @JsonKey(name: 'createdAt')
  final DateTime? createdAt;
  @JsonKey(name: 'updatedAt')
  final DateTime? updatedAt;
  @JsonKey(name: '__v')
  final int? v;
  @JsonKey(name: 'isSuperAdmin')
  final bool? isSuperAdmin;
  @JsonKey(name: 'sold')
  final int? sold;
  @JsonKey(name: 'rateAvg')
  final num? rateAvg;
  @JsonKey(name: 'rateCount')
  final int? rateCount;

  const ProductModel({
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
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
    id: json['_id'] as String?,
    title: json['title'] as String?,
    slug: json['slug'] as String?,
    description: json['description'] as String?,
    imgCover: json['imgCover'] as String?,
    images: (json['images'] as List<dynamic>?)
        ?.map((e) => e.toString())
        .toList(),
    price: (json['price'] as num?)?.toInt(),
    priceAfterDiscount: (json['priceAfterDiscount'] as num?)?.toInt(),
    quantity: (json['quantity'] as num?)?.toInt(),
    category: json['category'] is Map
        ? json['category']['name']
        : json['category']?.toString(),
    occasion: json['occasion'] is Map
        ? json['occasion']['name']
        : json['occasion']?.toString(),
    createdAt: json['createdAt'] == null
        ? null
        : DateTime.tryParse(json['createdAt'] as String),
    updatedAt: json['updatedAt'] == null
        ? null
        : DateTime.tryParse(json['updatedAt'] as String),
    v: (json['__v'] as num?)?.toInt(),
    isSuperAdmin: json['isSuperAdmin'] as bool?,
    sold: (json['sold'] as num?)?.toInt(),
    rateAvg: json['rateAvg'] as num?,
    rateCount: (json['rateCount'] as num?)?.toInt(),
  );

  Map<String, dynamic> toJson() => {
    '_id': id,
    'title': title,
    'slug': slug,
    'description': description,
    'imgCover': imgCover,
    'images': images,
    'price': price,
    'priceAfterDiscount': priceAfterDiscount,
    'quantity': quantity,
    'category': category,
    'occasion': occasion,
    'createdAt': createdAt?.toIso8601String(),
    'updatedAt': updatedAt?.toIso8601String(),
    '__v': v,
    'isSuperAdmin': isSuperAdmin,
    'sold': sold,
    'rateAvg': rateAvg,
    'rateCount': rateCount,
  };

  ProductEntity toEntity() {
    return ProductEntity(
      id: id ?? '',
      title: title ?? '',
      slug: slug ?? '',
      description: description ?? '',
      imgCover: imgCover ?? '',
      images: images ?? [],
      price: price?.toDouble() ?? 0.0,
      priceAfterDiscount: priceAfterDiscount?.toDouble() ?? 0.0,
      discount: ((price != null && priceAfterDiscount != null && price! > 0)
          ? (((price! - priceAfterDiscount!) / price!) * 100).round()
          : 0),
      quantity: quantity ?? 0,
      category: category ?? '',
      occasion: occasion ?? '',
      createdAt: createdAt ?? DateTime.now(),
      updatedAt: updatedAt ?? DateTime.now(),
      v: v ?? 0,
      isSuperAdmin: isSuperAdmin ?? false,
      sold: sold ?? 0,
      rateAvg: rateAvg?.toDouble() ?? 0.0,
      rateCount: rateCount ?? 0,
    );
  }
}
