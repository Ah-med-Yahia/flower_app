import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/config/base_state/base_state.dart';
import 'package:flower_app/core/shared/domain/entities/products_response_entity/products_response_entity.dart';
import 'package:flower_app/core/shared/domain/use_cases.dart/get_products_use_cases.dart';
import 'package:flower_app/features/products/occasion/domain/entities/get_all_occasions_list_entity.dart';
import 'package:flower_app/features/products/occasion/domain/usecases/get_all_occasion_usecase.dart';
import 'package:flower_app/features/products/occasion/presentation/view_model/occasion_event.dart';
import 'package:flower_app/features/products/occasion/presentation/view_model/occasion_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class OccasionCubit extends Cubit<OccasionState> {
  final GetAllOccasionUsecase _getAllOccasionUseCase;
  final GetProductsUseCase _getOccasionProductsUseCase;

  OccasionCubit(this._getAllOccasionUseCase, this._getOccasionProductsUseCase)
    : super(
        OccasionState(
          occasionState: const BaseState<GetOccasionListEntity>(),
          occasionProductsState: const BaseState<ProductsResponseEntity>(),
          selectedIndex: 0,
        ),
      );

  void onEvent(OccasionEvent event) {
    switch (event) {
      case GetAllOccasions():
        _getAllOccasions(event.initialOccasionId);
      case SelectOccasion():
        _selectOccasion(event.index);
      case GetOccasionProducts():
        _getOccasionProducts(event.occasionId);
    }
  }

  Future<void> _getAllOccasions(String? initialOccasionId) async {
    emit(
      state.copyWith(
        occasionState: const BaseState<GetOccasionListEntity>(isLoading: true),
      ),
    );
    final occasions = await _getAllOccasionUseCase.getAllOccasions();
    occasions.when(
      success: (data) {
        int selectedIndex = 0;

        if (data.occasions != null && data.occasions!.isNotEmpty) {
          if (initialOccasionId != null) {
            final index = data.occasions!.indexWhere(
              (occasion) => occasion.id == initialOccasionId,
            );

            if (index != -1) {
              selectedIndex = index;
            } else {
              selectedIndex = 0;
            }
          } else {
            selectedIndex = 0;
          }
        }

        emit(
          state.copyWith(
            occasionState: BaseState<GetOccasionListEntity>(
              data: data,
              isLoading: false,
            ),
            selectedIndex: selectedIndex,
          ),
        );
        final occasionsList = data.occasions ?? [];

        if (occasionsList.isNotEmpty) {
          final occasionId = occasionsList[selectedIndex].id;
          if (occasionId != null) {
            _getOccasionProducts(occasionId);
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
        occasionProductsState: const BaseState<ProductsResponseEntity>(
          isLoading: true,
        ),
      ),
    );
    final occasionProducts = await _getOccasionProductsUseCase(
      occasionId: occasionId,
    );
    occasionProducts.when(
      success: (data) => emit(
        state.copyWith(
          occasionProductsState: BaseState<ProductsResponseEntity>(
            data: data,
            isLoading: false,
          ),
        ),
      ),
      failure: (error) => emit(
        state.copyWith(
          occasionProductsState: BaseState<ProductsResponseEntity>(
            errorMessage: error.errorModel.message,
            isLoading: false,
          ),
        ),
      ),
    );
  }
}
