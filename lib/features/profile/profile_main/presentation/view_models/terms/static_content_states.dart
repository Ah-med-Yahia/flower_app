import 'package:equatable/equatable.dart';

import '../../../../../../config/base_state/base_state.dart';
import '../../../../../../core/constants/errors_constants.dart';
import '../../../domain/entities/term_section_entity.dart';

class StaticContentStates extends Equatable {
  // Use List<TermSectionEntity> as the common denominator
  final BaseState<List<TermSectionEntity>> contentState;

  const StaticContentStates({
    this.contentState = const BaseState<List<TermSectionEntity>>(),
  });

  StaticContentStates copyWith({
    BaseState<List<TermSectionEntity>>? contentState,
  }) {
    return StaticContentStates(contentState: contentState ?? this.contentState);
  }

  bool get contentIsLoading => contentState.isLoading;

  String get contentErrorMessage =>
      contentState.errorMessage ?? ErrorsConstant.defaultError;

  List<TermSectionEntity> get contentsData => contentState.data ?? [];

  @override
  List<Object?> get props => [contentState];
}
