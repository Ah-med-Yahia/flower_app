import 'package:flutter/material.dart';

import '../../../../../core/constants/app_text_constants.dart';
import '../../domain/entities/about_app_entity.dart';
import '../../domain/entities/term_section_entity.dart';
import '../models/app_app/flowery_about_app_model.dart';
import '../models/terms_and_conditions/bilingual_content.dart';
import '../models/terms_and_conditions/bilingual_list.dart';
import '../models/terms_and_conditions/section_style.dart';
import '../models/terms_and_conditions/term_section.dart';
import '../models/terms_and_conditions/terms_and_conditions.dart';
import '../models/terms_and_conditions/text_style_config.dart';
import 'terms_mapper.dart';

/// Todo(Ahmed-Salah): Next PR Refactor [AboutMapper] and [TermsMapper]
/// Todo(Ahmed-Salah): Next PR Refactor [FloweryAboutAppModel] and [TermsAndConditions]
class AboutMapper {
  AboutMapper._();

  /// Converts the high-level API model to the Domain Entity used by the UI.
  static AboutAppEntity toEntity(FloweryAboutAppModel model) {
    return AboutAppEntity(
      aboutApp:
          model.aboutApp
              ?.map((section) => _toSectionEntity(section))
              .toList() ??
          [],
    );
  }

  static const String _enLangKey = AppTextConstants.enLang;
  static const String _arLangKey = AppTextConstants.arLang;

  /// Maps an individual section to its entity.
  static TermSectionEntity _toSectionEntity(TermSection model) {
    return TermSectionEntity(
      section: model.section,
      title: model.title != null
          ? {_enLangKey: model.title!.en, _arLangKey: model.title!.ar}
          : null,
      content: _mapBilingualContent(model.content),
      style: _toSectionStyleEntity(model.style),
    );
  }

  /// Helper to handle the dynamic nature of content (List vs String).
  static Map<String, dynamic>? _mapBilingualContent(dynamic content) {
    if (content == null) return null;

    if (content is BilingualList) {
      return {_enLangKey: content.en, _arLangKey: content.ar};
    } else if (content is BilingualContent) {
      return {_enLangKey: content.en, _arLangKey: content.ar};
    }
    return null;
  }

  /// Converts raw style strings into Flutter-native objects (Colors, Alignments).
  static SectionStyleEntity _toSectionStyleEntity(SectionStyle model) {
    return SectionStyleEntity(
      title: model.title != null ? _toTextStyleEntity(model.title!) : null,
      content: model.content != null
          ? _toTextStyleEntity(model.content!)
          : null,
      fontSize: model.fontSize,
      fontWeight: _parseFontWeight(model.fontWeight),
      color: _parseColor(model.color),
      textAlign: model.textAlign != null
          ? {
              _enLangKey: _parseTextAlign(model.textAlign!.en),
              _arLangKey: _parseTextAlign(model.textAlign!.ar),
            }
          : null,
    );
  }

  /// Maps specific text configurations.
  static TextStyleEntity _toTextStyleEntity(TextStyleConfig model) {
    return TextStyleEntity(
      fontSize: model.fontSize,
      fontWeight: _parseFontWeight(model.fontWeight),
      color: _parseColor(model.color),
      textAlign: {
        _enLangKey: _parseTextAlign(model.textAlign.en),
        _arLangKey: _parseTextAlign(model.textAlign.ar),
      },
    );
  }

  /// Safely parses Hex color strings (e.g., "#FFFFFF").
  static Color _parseColor(String? colorString) {
    if (colorString == null) return Colors.black;
    try {
      if (colorString.startsWith('#')) {
        return Color(
          int.parse(colorString.substring(1), radix: 16) + 0xFF000000,
        );
      }
    } catch (e) {
      return Colors.black;
    }
    return Colors.black;
  }

  // Converts String weights from JSON to Flutter FontWeight.
  static FontWeight _parseFontWeight(String? weight) {
    if (weight == null) return FontWeight.normal;
    switch (weight.toLowerCase()) {
      case 'bold':
        return FontWeight.bold;
      case 'normal':
      default:
        return FontWeight.normal;
    }
  }

  /// Converts String alignment from JSON to Flutter TextAlign.
  static TextAlign _parseTextAlign(String? align) {
    if (align == null) return TextAlign.left;
    switch (align.toLowerCase()) {
      case 'center':
        return TextAlign.center;
      case 'right':
        return TextAlign.right;
      case 'left':
      default:
        return TextAlign.left;
    }
  }
}
