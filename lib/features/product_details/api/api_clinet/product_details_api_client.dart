import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:flower_app/core/constants/api_constants.dart';
import 'package:flower_app/features/product_details/data/models/product_response_dto.dart';
import 'package:retrofit/retrofit.dart'; // ← This single import includes everything

part 'product_details_api_client.g.dart';

@RestApi()
@injectable
abstract class ProductDetailsApiClient {
  @factoryMethod
  factory ProductDetailsApiClient(Dio dio) = _ProductDetailsApiClient;

  @GET(ApiConstants.productByIdEndpoint)
  Future<ProductResponseDto> getProductDetails(
    @Path(ApiConstants.idPathQuery) String id,
  );
}
