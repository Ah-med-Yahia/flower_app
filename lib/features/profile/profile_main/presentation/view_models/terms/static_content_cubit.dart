import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../config/base_response/base_response.dart';
import '../../../../../../config/base_state/base_state.dart';
import '../../../domain/entities/about_app_entity.dart';
import '../../../domain/entities/term_section_entity.dart';
import '../../../domain/use_cases/get_about_app_use_case.dart';
import '../../../domain/use_cases/get_term_use_case.dart';
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
        _loadAboutData();
    }
  }

  Future<void> _loadTermData() async {
    await _handleDataLoad<TermsAndConditionsEntity>(
      () => _getTermUseCase.call(),
      (baseState) => state.copyWith(legalState: baseState),
    );
  }

  Future<void> _loadAboutData() async {
    await _handleDataLoad<AboutAppEntity>(
      () => _getAboutAppUseCase.call(),
      (baseState) => state.copyWith(aboutState: baseState),
    );
  }

  Future<void> _handleDataLoad<T>(
    Future<BaseResponse<T>> Function() useCaseCall,
    Function(BaseState<T> baseState) stateUpdate,
  ) async {
    // 1. Set Loading
    emit(stateUpdate(BaseState<T>(isLoading: true)));

    // 2. Execute Use Case
    final res = await useCaseCall();

    // 3. Map Result to State
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

  //
  // Future<void> __loadTermData() async {
  //   emit(
  //     state.copyWith(
  //       legalState: const BaseState<TermsAndConditionsEntity>(isLoading: true),
  //     ),
  //   );
  //   final BaseResponse<TermsAndConditionsEntity> res = await _getTermUseCase
  //       .call();
  //   res.when(
  //     success: (data) {
  //       emit(
  //         state.copyWith(
  //           legalState: BaseState<TermsAndConditionsEntity>(
  //             isLoading: false,
  //             data: data,
  //           ),
  //         ),
  //       );
  //     },
  //     failure: (error) {
  //       emit(
  //         state.copyWith(
  //           legalState: BaseState<TermsAndConditionsEntity>(
  //             isLoading: false,
  //             errorMessage: error.message,
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }
  //
  // Future<void> __loadAboutData() async {
  //   emit(
  //     state.copyWith(
  //       aboutState: const BaseState<AboutAppEntity>(isLoading: true),
  //     ),
  //   );
  //
  //   final BaseResponse<AboutAppEntity> res = await _getAboutAppUseCase.call();
  //   res.when(
  //     success: (data) {
  //       emit(
  //         state.copyWith(
  //           aboutState: BaseState<AboutAppEntity>(
  //             isLoading: false,
  //             data: data,
  //             errorMessage: null,
  //           ),
  //         ),
  //       );
  //     },
  //     failure: (error) {
  //       emit(
  //         state.copyWith(
  //           aboutState: BaseState<AboutAppEntity>(
  //             isLoading: false,
  //             errorMessage: error.message,
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }
}
