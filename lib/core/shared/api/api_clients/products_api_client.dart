import 'package:dio/dio.dart';
import 'package:flower_app/core/constants/api_constants.dart';
import 'package:flower_app/core/shared/data/models/get_products_models/products_response_model.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'products_api_client.g.dart';

@RestApi()
@lazySingleton
abstract class ProductsApiClient {
  @factoryMethod
  factory ProductsApiClient(Dio dio) = _ProductsApiClient;

  @GET(ApiConstants.getProducts)
  Future<ProductsResponseModel> getProducts({
    @Query(QueryParamsKey.search) String? keyword,
    @Query(QueryParamsKey.categoryId) String? categoryId,
    @Query(QueryParamsKey.sort) String? sortOption,
    @Query(QueryParamsKey.occasionId) String? occasionId,
  });
}
