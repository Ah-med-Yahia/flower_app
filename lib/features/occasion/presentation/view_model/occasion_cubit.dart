import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../config/base_response/base_response.dart';
import '../../../../config/base_state/base_state.dart';
import '../../domain/entities/get_all_occasions_list_entity.dart';
import '../../domain/entities/get_occasion_products_entity.dart';
import '../../domain/usecases/get_all_occasion_usecase.dart';
import '../../domain/usecases/get_occasion_products_usecase.dart';
import 'occasion_event.dart';
import 'occasion_state.dart';

@injectable
class OccasionCubit extends Cubit<OccasionState> {
  final GetAllOccasionUsecase _getAllOccasionUseCase;
  final GetOccasionProductsUsecase _getOccasionProductsUseCase;

  OccasionCubit(this._getAllOccasionUseCase, this._getOccasionProductsUseCase)
    : super(
        OccasionState(
          occasionState: const BaseState<GetOccasionListEntity>(),
          occasionProductsState: const BaseState<GetOccasionProductsEntity>(),
          selectedIndex: 0,
        ),
      );

  void onEvent(OccasionEvent event) {
    switch (event) {
      case GetAllOccasions():
        _getAllOccasions();
      case SelectOccasion():
        _selectOccasion(event.index);
      case GetOccasionProducts():
        _getOccasionProducts(event.occasionId);
    }
  }

  Future<void> _getAllOccasions() async {
    emit(
      state.copyWith(
        occasionState: const BaseState<GetOccasionListEntity>(isLoading: true),
      ),
    );
    final occasions = await _getAllOccasionUseCase.getAllOccasions();
    occasions.when(
      success: (data) {
        emit(
          state.copyWith(
            occasionState: BaseState<GetOccasionListEntity>(
              data: data,
              isLoading: false,
            ),
          ),
        );

        if (data.occasions != null && data.occasions!.isNotEmpty) {
          final firstOccasionId = data.occasions![0].id;

          if (firstOccasionId != null) {
            _getOccasionProducts(firstOccasionId);
          }
        }
      },
      failure: (error) => emit(
        state.copyWith(
          occasionState: BaseState<GetOccasionListEntity>(
            errorMessage: error.errorModel.message,
            isLoading: false,
          ),
        ),
      ),
    );
  }

  void _selectOccasion(int index) {
    emit(state.copyWith(selectedIndex: index));

    final occasions = state.occasionState.data?.occasions ?? [];

    if (index < occasions.length) {
      final occasionId = occasions[index].id;

      if (occasionId != null) {
        _getOccasionProducts(occasionId);
      }
    }
  }

  Future<void> _getOccasionProducts(String occasionId) async {
    emit(
      state.copyWith(
        occasionProductsState: const BaseState<GetOccasionProductsEntity>(
          isLoading: true,
        ),
      ),
    );
    final occasionProducts = await _getOccasionProductsUseCase
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
            errorMessage: error.errorModel.message,
            isLoading: false,
          ),
        ),
      ),
    );
  }
}
