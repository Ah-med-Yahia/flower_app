import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../config/base_response/base_response.dart';
import '../../../../../../config/base_state/base_state.dart';
import '../../../domain/entities/term_section_entity.dart';
import '../../../domain/use_cases/get_about_app_use_case.dart';
import '../../../domain/use_cases/get_term_use_case.dart';
import 'static_content_events.dart';
import 'static_content_states.dart';

@injectable
class StaticContentCubit extends Cubit<StaticContentStates> {
  final GetTermUseCase _getTermUseCase;
  final GetAboutAppUseCase _getAboutAppUseCase;

  StaticContentCubit(this._getTermUseCase, this._getAboutAppUseCase)
    : super(const StaticContentStates());

  void doIntent(StaticContentEvents event) async {
    switch (event) {
      case GetTermDataEvent():
        await _loadTermData();
      case GetAboutAppDataEvent():
        await _loadAboutData();
    }
  }

  Future<void> _loadTermData() async {
    await _handleDataLoad<List<TermSectionEntity>>(
      () => _getTermUseCase.call(),
      (baseState) => state.copyWith(contentState: baseState),
    );
  }

  Future<void> _loadAboutData() async {
    await _handleDataLoad<List<TermSectionEntity>>(
      () => _getAboutAppUseCase.call(),
      (baseState) => state.copyWith(contentState: baseState),
    );
  }

  Future<void> _handleDataLoad<T>(
    Future<BaseResponse<T>> Function() useCaseCall,
    StaticContentStates Function(BaseState<T> baseState) stateUpdate,
  ) async {
    // 1. Set Loading
    emit(stateUpdate(BaseState<T>(isLoading: true)));

    // 2. Add Fake Loading Delay (e.g., 1 seconds)
    await Future.delayed(const Duration(seconds: 1));

    // 3. Execute Use Case
    final res = await useCaseCall();

    // 4. Map Result to State
    res.when(
      success: (data) =>
          emit(stateUpdate(BaseState<T>(isLoading: false, data: data))),
      failure: (error) => emit(
        stateUpdate(
          BaseState<T>(isLoading: false, errorMessage: error.message),
        ),
      ),
    );
  }
}
