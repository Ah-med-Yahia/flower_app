import 'package:flower_app/core/shared/data/mappers/product_mapper.dart';
import 'package:flower_app/core/shared/data/models/get_products_models/products_response_model.dart';
import 'package:flower_app/core/shared/domain/entities/products_response_entity/products_response_entity.dart';

extension ProductsResponseMapper on ProductsResponseModel {
  ProductsResponseEntity toEntity() {
    return ProductsResponseEntity(
      products: products?.map((e) => e.toEntity()).toList() ?? [],
    );
  }
}
