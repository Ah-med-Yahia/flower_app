import 'package:flower_app/core/shared/domain/entities/products_response_entity/product_entity.dart';

class ProductsResponseEntity {
  final List<ProductEntity> products;

  ProductsResponseEntity({required this.products});

  ProductsResponseEntity copyWith({List<ProductEntity>? products}) {
    return ProductsResponseEntity(products: products ?? this.products);
  }
}
