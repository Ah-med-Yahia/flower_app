import '../../../../config/base_state/base_state.dart';
import '../../domain/models/product_response_model.dart';

class ProductDetailsStates {
  BaseState<ProductResponseModel>? productDetailsState;

  ProductDetailsStates({this.productDetailsState});
  ProductDetailsStates copyWith({
    BaseState<ProductResponseModel>? productDetailsState,
  }) {
    return ProductDetailsStates(
      productDetailsState: productDetailsState ?? this.productDetailsState,
    );
  }
}
