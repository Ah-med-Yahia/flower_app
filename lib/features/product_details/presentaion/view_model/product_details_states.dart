import 'package:flower_app/config/base_state/base_state.dart';
import 'package:flower_app/features/product_details/domain/models/product_response_model.dart';

class ProductDetailsStates {
  BaseState<ProductResponseModel>? productDetailsState;

  ProductDetailsStates({
    this.productDetailsState,
  });
  ProductDetailsStates copyWith({
    BaseState<ProductResponseModel>? productDetailsState,
  }) {
    return ProductDetailsStates(
      productDetailsState: productDetailsState ?? this.productDetailsState,
    );
  }
}
