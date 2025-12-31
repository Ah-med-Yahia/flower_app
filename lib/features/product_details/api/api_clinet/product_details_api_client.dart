import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:online_exam_app/core/constants/api_constants.dart';
import 'package:online_exam_app/features/product_details/data/models/product_response_dto.dart';
import 'package:retrofit/retrofit.dart'; // ← This single import includes everything

part 'product_details_api_client.g.dart';

@RestApi()
@injectable
abstract class ProductDetailsApiClient {
  @factoryMethod
  factory ProductDetailsApiClient(Dio dio) = _ProductDetailsApiClient;

  @GET(ApiConstants.productsEndpoint)
  Future<ProductResponseDto> getProductDetails(@Path("id") String id);
}
