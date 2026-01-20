import 'package:flower_app/features/home/domain/entities/product_entity.dart';
import 'package:flower_app/features/product_details/data/models/product_dto.dart';

extension ProductDtoMapper on ProductDto {
  ProductEntity toEntity() {
    return ProductEntity(
      id: id,
      title: title,
      slug: slug,
      description: description,
      imgCover: imgCover,
      images: images,
      price: price,
      priceAfterDiscount: priceAfterDiscount,
      quantity: quantity,
      category: category,
      occasion: occasion,
      createdAt: createdAt,
      updatedAt: updatedAt,
      v: v,
      isSuperAdmin: isSuperAdmin,
      rateAvg: rateAvg,
      rateCount: rateCount,
    );
  }
}
