import 'package:flower_app/features/categories/domain/entities/categories_product_entity.dart';

class GetCategoryProductsEntity {
  final CategoryProductEntity? products;

  GetCategoryProductsEntity({required this.products});

  GetCategoryProductsEntity copyWith({CategoryProductEntity? products}) {
    return GetCategoryProductsEntity(products: products ?? this.products);
  }
}
