import 'package:equatable/equatable.dart';

import 'term_section_entity.dart';

class AboutAppEntity extends Equatable {
  final List<TermSectionEntity> aboutApp;

  const AboutAppEntity({required this.aboutApp});

  @override
  List<Object?> get props => [aboutApp];
}
