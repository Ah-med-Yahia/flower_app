import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/config/base_state/base_state.dart';
import 'package:flower_app/features/home/domain/usecases/get_home_data_usecase.dart';
import 'package:flower_app/features/home/presentation/view_model/home_screen_events.dart';
import 'package:flower_app/features/home/presentation/view_model/home_screen_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class HomeScreenCubit extends Cubit<HomeScreenStates> {
  final GetHomeDataUsecase getHomeDataUsecase;
  HomeScreenCubit(this.getHomeDataUsecase) : super(HomeScreenStates());

  void onEvent(HomeScreenEvents event) {
    switch (event) {
      case GetHomeScreenDataEvent():
        _getHomeScreenData();
    }
  }

  void _getHomeScreenData() async {
    emit(
      state.copyWith(
        homeScreenStates: BaseState(
          isLoading: true,
          data: null,
          errorMessage: null,
        ),
      ),
    );
    final response = await getHomeDataUsecase.call();
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

  // void _navigateToCategoryScreen(String? categoryId) {
  //   if (categoryId != null) {}
  // }

  // void _navigateToBestSellerScreen(String? productId) {}
  // void _navigateToOccasionScreen(String? occasionId) {}
  // void _navigateToProductDetailsScreen(String productId) {}
}
