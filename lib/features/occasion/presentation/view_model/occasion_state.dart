import 'package:online_exam_app/config/base_state/base_state.dart';
import 'package:online_exam_app/features/occasion/domain/entities/get_all_occasion_entity.dart';

class OccasionState {
  final BaseState<GetAllOccasionEntity> occasionState;

  OccasionState({required this.occasionState});
  OccasionState copyWith({BaseState<GetAllOccasionEntity>? occasionState}) {
    return OccasionState(occasionState: occasionState ?? this.occasionState);
  }
}
