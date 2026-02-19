import 'package:flower_app/core/shared/data/models/get_products_models/product_model.dart';
import 'package:flower_app/core/shared/domain/entities/products_response_entity/product_entity.dart';

extension ProductMapper on ProductModel {
  ProductEntity toEntity() {
    return ProductEntity(
      id: id,
      title: title,
      imageCover: imgCover,
      price: price,
      priceAfterDiscount: priceAfterDiscount,
      description: description,
      images: images,
      discount: discount,
      categoryId: category,
      occasionId: occasion,
      quantity: quantity ?? 0,
    );
  }
}
