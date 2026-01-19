import 'package:flower_app/features/product_details/data/models/product_dto.dart';
import 'package:flower_app/features/product_details/domain/models/product_model.dart';

extension ProductDtoMapper on ProductDto {
  ProductModel toDomain() {
    return ProductModel(
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
      sold: sold,
      rateAvg: rateAvg,
      rateCount: rateCount,
      isInWishlist: isInWishlist,
      favoriteId: favoriteId,
    );
  }
}
