import 'package:equatable/equatable.dart';

import '../../../../../../config/base_state/base_state.dart';
import '../../../../../../core/constants/errors_constants.dart';
import '../../../domain/entities/about_app_entity.dart';
import '../../../domain/entities/term_section_entity.dart';

class StaticContentStates extends Equatable {
  final BaseState<TermsAndConditionsEntity> legalState;
  final BaseState<AboutAppEntity> aboutState;

  // Use List<TermSectionEntity> as the common denominator
  final BaseState<List<TermSectionEntity>> contentState;

  const StaticContentStates({
    this.legalState = const BaseState<TermsAndConditionsEntity>(),
    this.aboutState = const BaseState<AboutAppEntity>(),
    this.contentState = const BaseState<List<TermSectionEntity>>(),
  });

  StaticContentStates copyWith({
    BaseState<TermsAndConditionsEntity>? legalState,
    BaseState<AboutAppEntity>? aboutState,
    BaseState<List<TermSectionEntity>>? contentState,
  }) {
    return StaticContentStates(
      legalState: legalState ?? this.legalState,
      aboutState: aboutState ?? this.aboutState,
      contentState: contentState ?? this.contentState,
    );
  }

  bool get isLoading => contentState.isLoading;

  String? get errorMessage =>
      contentState.errorMessage ?? ErrorsConstant.defaultError;

  List<TermSectionEntity>? get date => contentState.data ?? [];

  @override
  List<Object?> get props => [legalState, aboutState, contentState];
}

sealed class StaticContentEvents {}

class GetTermDataEvent extends StaticContentEvents {}

class GetAboutAppDataEvent extends StaticContentEvents {}
