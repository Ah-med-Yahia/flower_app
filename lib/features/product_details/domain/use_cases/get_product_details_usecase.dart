import 'package:injectable/injectable.dart';

import '../../../../config/base_response/base_response.dart';
import '../models/product_response_model.dart';
import '../repo/product_details_repo_contract.dart';

@injectable
class GetProductDetailsUsecase {
  ProductDetailsRepoContract repo;
  GetProductDetailsUsecase(this.repo);

  Future<BaseResponse<ProductResponseModel>> call(String productId) =>
      repo.getProductDetails(productId);
}
