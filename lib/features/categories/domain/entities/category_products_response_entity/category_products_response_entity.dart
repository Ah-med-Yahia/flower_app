import 'package:flower_app/features/categories/domain/entities/category_products_response_entity/product_entity.dart';

class GetCategoryProductsEntity {
  final List<ProductEntity> products;

  GetCategoryProductsEntity({required this.products});

  GetCategoryProductsEntity copyWith({List<ProductEntity>? products}) {
    return GetCategoryProductsEntity(products: products ?? this.products);
  }
}
