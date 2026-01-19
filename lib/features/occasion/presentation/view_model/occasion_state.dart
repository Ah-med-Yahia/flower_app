import 'package:flower_app/config/base_state/base_state.dart';
import 'package:flower_app/features/occasion/domain/entities/get_all_occasion_entity.dart';
import 'package:flower_app/features/occasion/domain/entities/get_occasion_products_entity.dart';

class OccasionState {
  final BaseState<GetAllOccasionEntity> occasionState;
  final BaseState<GetOccasionProductsEntity> occasionProductsState;
  final int selectedIndex;

  OccasionState({
    required this.occasionState,
    this.selectedIndex = 0,
    required this.occasionProductsState,
  });
  OccasionState copyWith({
    BaseState<GetAllOccasionEntity>? occasionState,
    int? selectedIndex,
    BaseState<GetOccasionProductsEntity>? occasionProductsState,
  }) {
    return OccasionState(
      occasionState: occasionState ?? this.occasionState,
      selectedIndex: selectedIndex ?? this.selectedIndex,
      occasionProductsState:
          occasionProductsState ?? this.occasionProductsState,
    );
  }
}
