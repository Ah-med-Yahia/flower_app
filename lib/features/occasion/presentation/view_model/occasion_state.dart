import 'package:flower_app/config/base_state/base_state.dart';
import 'package:flower_app/features/occasion/domain/entities/get_all_occasions_list_entity.dart';

class OccasionState {
  final BaseState<GetOccasionListEntity> occasionState;
  final int selectedIndex;

  OccasionState({required this.occasionState, this.selectedIndex = 0});
  OccasionState copyWith({
    BaseState<GetOccasionListEntity>? occasionState,
    int? selectedIndex,
  }) {
    return OccasionState(
      occasionState: occasionState ?? this.occasionState,
      selectedIndex: selectedIndex ?? this.selectedIndex,
    );
  }
}
