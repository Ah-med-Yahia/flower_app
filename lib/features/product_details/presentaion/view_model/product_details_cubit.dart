import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:online_exam_app/config/base_response/base_response.dart';
import 'package:online_exam_app/features/product_details/domain/use_cases/get_product_details_usecase.dart';
import 'package:online_exam_app/features/product_details/presentaion/view_model/product_details_events.dart';
import 'package:online_exam_app/features/product_details/presentaion/view_model/product_details_states.dart';
import 'package:online_exam_app/config/base_state/base_state.dart';

@injectable
class ProductDetailsCubit extends Cubit<ProductDetailsStates> {
  ProductDetailsCubit(this._getProductDetailsUsecase)
    : super(ProductDetailsStates());
  final GetProductDetailsUsecase _getProductDetailsUsecase;

  void onEvent(ProductDetailsEvents event) {
    switch (event) {
      case GetProductDetailsEvent():
        {
          final pID = event.productId;
          _getProductDetails(pID);
        }
    }
  }

  void _getProductDetails(String productId) async {
    emit(
      state.copyWith(
        productDetailsState: BaseState(
          isLoading: true,
          data: null,
          errorMessage: null,
        ),
      ),
    );
    final response = await _getProductDetailsUsecase.call(productId);

    response.when(
      success: (data) {
        emit(
          state.copyWith(
            productDetailsState: BaseState(
              isLoading: false,
              data: data,
              errorMessage: null,
            ),
          ),
        );
      },
      failure: (error) {
        emit(
          state.copyWith(
            productDetailsState: BaseState(
              isLoading: false,
              errorMessage: error.message,
              data: null,
            ),
          ),
        );
      },
    );
  }
}
