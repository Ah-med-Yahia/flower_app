import 'package:flower_app/core/shared/data/models/get_products_models/products_response_model.dart';

abstract interface class ProductsRemoteDataSources {
  Future<ProductsResponseModel> getProducts({
    String? keyword,
    String? categoryId,
    String? sortOption,
  });
}
