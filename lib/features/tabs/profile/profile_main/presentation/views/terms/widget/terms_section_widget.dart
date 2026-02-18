import 'package:flutter/material.dart';

import '../../../../../../../../core/constants/app_text_constants.dart';
import '../../../../../../../../core/shared/presentation/widgets/spacing.dart';
import '../../../../domain/entities/term_section_entity.dart';

class TermsSectionWidget extends StatelessWidget {
  final TermSectionEntity section;
  final String language;

  const TermsSectionWidget({
    super.key,
    required this.section,
    required this.language,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [if (section.title != null) _buildTitle(), _buildContent()],
      ),
    );
  }

  Widget _buildTitle() {
    final titleStyle = section.style.title;
    final titleText = section.title?[language];
    if (titleStyle == null || titleText == null) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        titleText,
        style: TextStyle(
          fontSize: titleStyle.fontSize,
          fontWeight: titleStyle.fontWeight,
          color: titleStyle.color,
        ),
        textAlign: titleStyle.textAlign[language] ?? TextAlign.start,
      ),
    );
  }

  Widget _buildContent() {
    final dynamic rawContent = section.content[language];
    if (rawContent == null) return const SizedBox.shrink();

    if (section.style.fontSize != null) {
      return Text(
        rawContent.toString(),
        style: TextStyle(
          fontSize: section.style.fontSize,
          fontWeight: section.style.fontWeight,
          color: section.style.color,
        ),
        textAlign: section.style.textAlign?[language] ?? TextAlign.start,
      );
    }

    final contentStyle = section.style.content;
    if (contentStyle == null) return const SizedBox.shrink();

    if (rawContent is List) {
      return _buildListContent(rawContent.cast<String>(), contentStyle);
    } else {
      return Text(
        rawContent.toString(),
        style: TextStyle(
          fontSize: contentStyle.fontSize,
          fontWeight: contentStyle.fontWeight,
          color: contentStyle.color,
        ),
        textAlign: contentStyle.textAlign[language] ?? TextAlign.start,
      );
    }
  }

  Widget _buildListContent(List<String> items, TextStyleEntity style) {
    final isRTL = language == AppTextConstants.arLangKey;

    return Column(
      crossAxisAlignment: isRTL
          ? CrossAxisAlignment.end
          : CrossAxisAlignment.start,
      children: items.map((item) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            textDirection: isRTL ? TextDirection.rtl : TextDirection.ltr,
            children: [
              Text(
                '• ',
                style: TextStyle(
                  fontSize: style.fontSize,
                  fontWeight: style.fontWeight,
                  color: style.color,
                ),
              ),
              4.horizontalSpacing,
              Expanded(
                child: Text(
                  item,
                  style: TextStyle(
                    fontSize: style.fontSize,
                    fontWeight: style.fontWeight,
                    color: style.color,
                  ),
                  textAlign: style.textAlign[language] ?? TextAlign.start,
                  textDirection: isRTL ? TextDirection.rtl : TextDirection.ltr,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
