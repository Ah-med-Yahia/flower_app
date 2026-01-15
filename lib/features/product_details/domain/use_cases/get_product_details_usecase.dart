import 'package:injectable/injectable.dart';
import 'package:online_exam_app/config/base_response/base_response.dart';
import 'package:online_exam_app/features/product_details/domain/models/product_response_model.dart';
import 'package:online_exam_app/features/product_details/domain/repo/product_details_repo_contract.dart';

@injectable
class GetProductDetailsUsecase {
  ProductDetailsRepoContract repo;
  GetProductDetailsUsecase(this.repo);

  Future<BaseResponse<ProductResponseModel>> call(String productId) =>
      repo.getProductDetails(productId);
}
