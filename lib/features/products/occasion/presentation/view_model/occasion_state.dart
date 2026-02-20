import 'package:flower_app/config/base_state/base_state.dart';
import 'package:flower_app/core/shared/domain/entities/products_response_entity/products_response_entity.dart';
import 'package:flower_app/features/products/occasion/domain/entities/get_all_occasions_list_entity.dart';

class OccasionState {
  final BaseState<GetOccasionListEntity> occasionState;
  final BaseState<ProductsResponseEntity> occasionProductsState;
  final int selectedIndex;

  OccasionState({
    required this.occasionState,
    this.selectedIndex = 0,
    required this.occasionProductsState,
  });
  OccasionState copyWith({
    BaseState<GetOccasionListEntity>? occasionState,
    int? selectedIndex,
    BaseState<ProductsResponseEntity>? occasionProductsState,
  }) {
    return OccasionState(
      occasionState: occasionState ?? this.occasionState,
      selectedIndex: selectedIndex ?? this.selectedIndex,
      occasionProductsState:
          occasionProductsState ?? this.occasionProductsState,
    );
  }
}
