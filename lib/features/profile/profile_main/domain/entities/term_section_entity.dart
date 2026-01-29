import 'package:flutter/material.dart';

class TermsAndConditionsEntity {
  final List<TermSectionEntity> sections;

  const TermsAndConditionsEntity({required this.sections});
}

class TermSectionEntity {
  final String section;
  final Map<String, String>? title; // Map 'en' and 'ar' to titles
  final dynamic content; // Map<String, String> or Map<String, List<String>>
  final SectionStyleEntity style;

  const TermSectionEntity({
    required this.section,
    this.title,
    required this.content,
    required this.style,
  });
}

class SectionStyleEntity {
  final TextStyleEntity? title;
  final TextStyleEntity? content;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? color;
  final Map<String, TextAlign>? textAlign; // Map 'en'/'ar' to TextAlign

  const SectionStyleEntity({
    this.title,
    this.content,
    this.fontSize,
    this.fontWeight,
    this.color,
    this.textAlign,
  });
}

class TextStyleEntity {
  final double fontSize;
  final FontWeight fontWeight;
  final Color color;
  final Map<String, TextAlign> textAlign; // Map 'en'/'ar' to TextAlign

  const TextStyleEntity({
    required this.fontSize,
    required this.fontWeight,
    required this.color,
    required this.textAlign,
  });
}
