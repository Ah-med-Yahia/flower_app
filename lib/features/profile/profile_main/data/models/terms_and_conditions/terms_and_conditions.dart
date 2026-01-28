import 'dart:convert';

import 'term_section.dart';

class TermsAndConditions {
  final List<TermSection> sections;

  TermsAndConditions({required this.sections});

  factory TermsAndConditions.fromJson(Map<String, dynamic> json) {
    return TermsAndConditions(
      sections: (json['terms_and_conditions'] as List)
          .map((section) => TermSection.fromJson(section))
          .toList(),
    );
  }

  static TermsAndConditions fromJsonString(String jsonString) {
    final Map<String, dynamic> json = jsonDecode(jsonString);
    return TermsAndConditions.fromJson(json);
  }
}
