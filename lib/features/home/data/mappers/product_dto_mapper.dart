import 'package:flower_app/features/home/data/models/home_screen_product_dto.dart';
import 'package:flower_app/features/home/domain/entities/product_entity.dart';

extension ProductDtoMapper on HomeScreenProductDto {
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
      isSuperAdmin: isSuperAdmin ?? false,
      rateAvg: rateAvg,
      rateCount: rateCount,
    );
  }
}
