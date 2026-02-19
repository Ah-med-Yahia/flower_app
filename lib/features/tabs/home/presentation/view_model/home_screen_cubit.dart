import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/config/base_state/base_state.dart';
import 'package:flower_app/features/tabs/home/domain/usecases/get_home_data_usecase.dart';
import 'package:flower_app/features/tabs/home/presentation/view_model/home_screen_events.dart';
import 'package:flower_app/features/tabs/home/presentation/view_model/home_screen_states.dart';
import 'package:flower_app/features/tabs/home/presentation/view_model/ui_events.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class HomeScreenCubit extends Cubit<HomeScreenStates> {
  final GetHomeDataUsecase getHomeDataUseCase;

  HomeScreenCubit(this.getHomeDataUseCase) : super(HomeScreenStates());

  void onEvent(HomeScreenEvents event) {
    switch (event) {
      case GetHomeScreenDataEvent():
        _getHomeScreenData();
      case WhenBestSellerIsClickedEvent():
        _navigateToProductDetails(event.productId);
      case WhenViewAllBestSellerIsClickedEvent():
        _navigateToBestSeller();
      case WhenCategoryIsClickedEvent():
        _navigateToCategoryDetails(event.categoryId);
      case WhenOccasionIsClickedEvent():
        _navigateToOccasionDetails(event.occasionId);
      case WhenCategoryViewAllIsClickedEvent():
        _navigateToCategoryDetails(null);
      case WhenOccasionViewAllIsClickedEvent():
        _navigateToOccasionDetails(null);
    }
  }

  void _getHomeScreenData() async {
    emit(
      state.copyWith(
        homeScreenStates: const BaseState(
          isLoading: true,
          data: null,
          errorMessage: null,
        ),
      ),
    );
    final response = await getHomeDataUseCase.call();
    response.when(
      success: (data) {
        emit(
          state.copyWith(
            homeScreenStates: BaseState(
              isLoading: false,
              data: data,
              errorMessage: null,
            ),
          ),
        );
      },
      failure: (errorHandler) => emit(
        state.copyWith(
          homeScreenStates: BaseState(
            isLoading: false,
            errorMessage: errorHandler.message,
            data: null,
          ),
        ),
      ),
    );
  }

  void _navigateToProductDetails(String productId) {
    emit(
      state.copyWith(navigationEvent: NavigateToProductDetailsEvent(productId)),
    );
  }

  void _navigateToBestSeller() {
    emit(state.copyWith(navigationEvent: NavigateToBestSellerScreenEvent()));
  }

  void _navigateToCategoryDetails(String? categoryId) {
    emit(state.copyWith(navigationEvent: NavigateToCategoryEvent(categoryId)));
  }

  void _navigateToOccasionDetails(String? occasionId) {
    emit(state.copyWith(navigationEvent: NavigateToOccasionEvent(occasionId)));
  }
}
