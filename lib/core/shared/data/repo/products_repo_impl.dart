import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/config/network/safe_api_call.dart';
import 'package:flower_app/core/shared/data/data_sources/products_remote_data_sources.dart';
import 'package:flower_app/core/shared/data/mappers/products_response_mapper.dart';
import 'package:flower_app/core/shared/domain/entities/products_response_entity/products_response_entity.dart';
import 'package:flower_app/core/shared/domain/repo/products_repo.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ProductsRepo)
class ProductsRepoImpl implements ProductsRepo {
  final ProductsRemoteDataSources _productsRemoteDataSources;

  ProductsRepoImpl(this._productsRemoteDataSources);

  @override
  Future<BaseResponse<ProductsResponseEntity>> getProducts({
    String? keyword,
    String? categoryId,
    String? sortOption,
    String? occasionId,
  }) async {
    return safeApiCall(() async {
      final response = await _productsRemoteDataSources.getProducts(
        keyword: keyword,
        categoryId: categoryId,
        sortOption: sortOption,
        occasionId: occasionId,
      );
      return response.toEntity();
    });
  }
}
