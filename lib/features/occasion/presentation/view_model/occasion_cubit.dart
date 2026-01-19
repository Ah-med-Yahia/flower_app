import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/config/base_state/base_state.dart';
import 'package:flower_app/features/occasion/domain/entities/get_all_occasion_entity.dart';
import 'package:flower_app/features/occasion/domain/entities/get_occasion_products_entity.dart';
import 'package:flower_app/features/occasion/domain/usecases/get_all_occasion_usecase.dart';
import 'package:flower_app/features/occasion/domain/usecases/get_occasion_products_usecase.dart';
import 'package:flower_app/features/occasion/presentation/view_model/occasion_event.dart';
import 'package:flower_app/features/occasion/presentation/view_model/occasion_state.dart';

@injectable
class OccasionCubit extends Cubit<OccasionState> {
  final GetAllOccasionUsecase getAllOccasionUsecase;
  final GetOccasionProductsUsecase getOccasionProductsUsecase;
  OccasionCubit({
    required this.getAllOccasionUsecase,
    required this.getOccasionProductsUsecase,
  }) : super(
         OccasionState(
           occasionState: BaseState<GetAllOccasionEntity>(),
           occasionProductsState: BaseState<GetOccasionProductsEntity>(),
         ),
       );
  void onEvent(OccasionEvent event) {
    switch (event) {
      case GetAllOccasions():
        _getAllOccasions();
      case SelectOccasion():
        _selectOccasion(event.index);
      case GetOccasionProducts():
        getOccasionProducts(event.occasionId);
    }
  }

  Future<void> _getAllOccasions() async {
    emit(
      state.copyWith(
        occasionState: BaseState<GetAllOccasionEntity>(isLoading: true),
      ),
    );
    final occasions = await getAllOccasionUsecase.getAllOccasions();
    occasions.when(
      success: (data) => emit(
        state.copyWith(
          occasionState: BaseState<GetAllOccasionEntity>(
            data: data,
            isLoading: false,
          ),
        ),
      ),
      failure: (error) => emit(
        state.copyWith(
          occasionState: BaseState<GetAllOccasionEntity>(
            errorMessage: error.errorModel.message,
            isLoading: false,
          ),
        ),
      ),
    );
  }

  void _selectOccasion(int index) {
    emit(state.copyWith(selectedIndex: index));
  }

  Future<void> getOccasionProducts(String occasionId) async {
    emit(
      state.copyWith(
        occasionProductsState: BaseState<GetOccasionProductsEntity>(
          isLoading: true,
        ),
      ),
    );
    final occasionProducts = await getOccasionProductsUsecase
        .getOccasionProducts(occasionId);
    occasionProducts.when(
      success: (data) => emit(
        state.copyWith(
          occasionProductsState: BaseState<GetOccasionProductsEntity>(
            data: data,
            isLoading: false,
          ),
        ),
      ),
      failure: (error) => emit(
        state.copyWith(
          occasionProductsState: BaseState<GetOccasionProductsEntity>(
            errorMessage: error.apiErrorModel.message,
            isLoading: false,
          ),
        ),
      ),
    );
  }
}
