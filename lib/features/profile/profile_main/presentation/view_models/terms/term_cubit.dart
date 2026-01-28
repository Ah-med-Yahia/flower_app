import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../config/base_response/base_response.dart';
import '../../../../../../config/base_state/base_state.dart';
import '../../../data/models/terms_and_conditions/terms_and_conditions.dart';
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
        termState: const BaseState<TermsAndConditions>(isLoading: true),
      ),
    );
    final BaseResponse<TermsAndConditions> res = await _getTermUseCase.call();
    res.when(
      success: (data) {
        emit(
          state.copyWith(
            termState: BaseState<TermsAndConditions>(
              isLoading: false,
              data: data,
            ),
          ),
        );
      },
      failure: (error) {
        emit(
          state.copyWith(
            termState: BaseState<TermsAndConditions>(
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
  final BaseState<TermsAndConditions> termState;

  const TermStates({this.termState = const BaseState<TermsAndConditions>()});

  TermStates copyWith({BaseState<TermsAndConditions>? termState}) {
    return TermStates(termState: termState ?? this.termState);
  }

  // Get the current Title
  String? get sectionTitle {
    for (int i = 0; i < termState.data!.sections.length; i++) {
      if (termState.data != null && termState.data!.sections.isNotEmpty) {
        return termState.data?.sections[i].section;
      }
    }
    return null;
  }

  @override
  List<Object?> get props => [termState];
}

sealed class TermEvents {}

class GetTermDataEvent extends TermEvents {}
