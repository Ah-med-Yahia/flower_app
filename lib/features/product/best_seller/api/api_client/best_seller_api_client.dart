import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:online_exam_app/features/product/best_seller/data/models/best_seller_response_dto.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../../core/constants/api_constants.dart';

part 'best_seller_api_client.g.dart';

@injectable
@RestApi()
abstract class BestSellerApiClient {
  @factoryMethod
  factory BestSellerApiClient(Dio dio) = _BestSellerApiClient;

  @GET(ApiConstants.bestSellerEndPoint)
  Future<BestSellerResponseDto> getBestSeller();
}
