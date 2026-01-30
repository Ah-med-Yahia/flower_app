import 'package:flower_app/core/constants/app_text_constants.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/term_section_entity.dart';
import '../models/terms_and_conditions/bilingual_content.dart';
import '../models/terms_and_conditions/bilingual_list.dart';
import '../models/terms_and_conditions/section_style.dart';
import '../models/terms_and_conditions/term_section.dart';
import '../models/terms_and_conditions/terms_and_conditions.dart';
import '../models/terms_and_conditions/text_style_config.dart';

class TermsMapper {
  TermsMapper._();

  static TermsAndConditionsEntity toEntity(TermsAndConditions model) {
    return TermsAndConditionsEntity(
      sections: model.sections
          .map((section) => _toSectionEntity(section))
          .toList(),
    );
  }

  static const String _enLangKey = AppTextConstants.enLang;
  static const String _arLangKey = AppTextConstants.arLang;

  static TermSectionEntity _toSectionEntity(TermSection model) {
    return TermSectionEntity(
      section: model.section,
      title: model.title != null
          ? {_enLangKey: model.title!.en, _arLangKey: model.title!.ar}
          : null,
      content: model.content is BilingualList
          ? {
              _enLangKey: (model.content as BilingualList).en,
              _arLangKey: (model.content as BilingualList).ar,
            }
          : {
              _enLangKey: (model.content as BilingualContent).en,
              _arLangKey: (model.content as BilingualContent).ar,
            },
      style: _toSectionStyleEntity(model.style),
    );
  }

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
