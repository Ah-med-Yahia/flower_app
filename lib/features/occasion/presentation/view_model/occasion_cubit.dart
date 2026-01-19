import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/config/base_state/base_state.dart';
import 'package:flower_app/features/occasion/domain/entities/get_all_occasion_entity.dart';
import 'package:flower_app/features/occasion/domain/usecases/get_all_occasion_usecase.dart';
import 'package:flower_app/features/occasion/presentation/view_model/occasion_event.dart';
import 'package:flower_app/features/occasion/presentation/view_model/occasion_state.dart';

@injectable
class OccasionCubit extends Cubit<OccasionState> {
  final GetAllOccasionUsecase getAllOccasionUsecase;
  OccasionCubit({required this.getAllOccasionUsecase})
    : super(OccasionState(occasionState: BaseState<GetAllOccasionEntity>()));
  void onEvent(OccasionEvent event) {
    switch (event) {
      case GetAllOccasions():
        _getAllOccasions();
      case SelectOccasion():
        _selectOccasion(event.index);
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
}
