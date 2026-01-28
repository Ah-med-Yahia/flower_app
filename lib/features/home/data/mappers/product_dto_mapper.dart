import '../../domain/entities/product_entity.dart';
import '../models/home_screen_product_dto.dart';

extension ProductDtoMapper on HomeScreenProductDto {
  ProductEntity toEntity() {
    return ProductEntity(
      id: id ?? '',
      title: title ?? '',
      slug: slug ?? '',
      description: description ?? '',
      imgCover: imgCover ?? '',
      images: images ?? [],
      price: price ?? 0,
      priceAfterDiscount: priceAfterDiscount ?? 0,
      quantity: quantity ?? 0,
      category: category ?? '',
      occasion: occasion ?? '',
      createdAt: createdAt ?? DateTime.now(),
      updatedAt: updatedAt ?? DateTime.now(),
      v: v ?? 0,
      isSuperAdmin: isSuperAdmin ?? false,
      rateAvg: rateAvg ?? 0,
      rateCount: rateCount ?? 0,
      discount: discount ?? 0,
      sold: sold ?? 0,
    );
  }
}
