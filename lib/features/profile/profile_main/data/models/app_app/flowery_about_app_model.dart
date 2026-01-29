import 'dart:convert';

import '../terms_and_conditions/term_section.dart';

class FloweryAboutAppModel {
  final List<TermSection>? aboutApp;

  FloweryAboutAppModel({this.aboutApp});

  factory FloweryAboutAppModel.fromJson(Map<String, dynamic> json) {
    return FloweryAboutAppModel(
      aboutApp: (json['about_app'] as List)
          .map((section) => TermSection.fromJson(section))
          .toList(),
    );
  }

  static FloweryAboutAppModel fromJsonString(String jsonString) {
    final Map<String, dynamic> json = jsonDecode(jsonString);
    return FloweryAboutAppModel.fromJson(json);
  }
}
