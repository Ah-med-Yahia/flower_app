import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../config/base_response/base_response.dart';
import '../../../../../../config/base_state/base_state.dart';
import '../../../domain/entities/term_section_entity.dart';
import '../../../domain/use_cases/get_term_use_case.dart';

@injectable
class TermCubit extends Cubit<TermStates> {
  final GetTermUseCase _getTermUseCase;

  TermCubit(this._getTermUseCase) : super(const TermStates());

  void doIntent(TermEvents event) async {
    switch (event) {
      case GetTermDataEvent():
        await _loadTermData();
    }
  }

  Future<void> _loadTermData() async {
    emit(
      state.copyWith(
        termState: const BaseState<TermsAndConditionsEntity>(isLoading: true),
      ),
    );
    final BaseResponse<TermsAndConditionsEntity> res = await _getTermUseCase
        .call();
    res.when(
      success: (data) {
        emit(
          state.copyWith(
            termState: BaseState<TermsAndConditionsEntity>(
              isLoading: false,
              data: data,
            ),
          ),
        );
      },
      failure: (error) {
        emit(
          state.copyWith(
            termState: BaseState<TermsAndConditionsEntity>(
              isLoading: false,
              errorMessage: error.message,
            ),
          ),
        );
      },
    );
  }
}

class TermStates extends Equatable {
  final BaseState<TermsAndConditionsEntity> termState;

  const TermStates({
    this.termState = const BaseState<TermsAndConditionsEntity>(),
  });

  TermStates copyWith({BaseState<TermsAndConditionsEntity>? termState}) {
    return TermStates(termState: termState ?? this.termState);
  }

  @override
  List<Object?> get props => [termState];
}

sealed class TermEvents {}

class GetTermDataEvent extends TermEvents {}
