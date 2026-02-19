import 'package:flower_app/core/shared/api/api_clients/products_api_client.dart';
import 'package:flower_app/core/shared/data/data_sources/products_remote_data_sources.dart';
import 'package:flower_app/core/shared/data/models/get_products_models/products_response_model.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ProductsRemoteDataSources)
class ProductsRemoteDataSourceImpl implements ProductsRemoteDataSources {
  final ProductsApiClient productsApiClient;

  ProductsRemoteDataSourceImpl(this.productsApiClient);

  @override
  Future<ProductsResponseModel> getProducts({
    String? keyword,
    String? categoryId,
    String? sortOption,
  }) {
    return productsApiClient.getProducts(
      keyword: keyword,
      categoryId: categoryId,
      sortOption: sortOption,
    );
  }
}
