import 'package:flower_app/features/categories/domain/entities/category_products_response_entity/category_product_entity.dart';

class GetCategoryProductsEntity {
  final List<CategoryProductEntity> products;

  GetCategoryProductsEntity({required this.products});

  GetCategoryProductsEntity copyWith({List<CategoryProductEntity>? products}) {
    return GetCategoryProductsEntity(products: products ?? this.products);
  }
}
