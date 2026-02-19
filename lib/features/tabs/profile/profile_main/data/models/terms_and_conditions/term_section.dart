import 'bilingual_content.dart';
import 'bilingual_list.dart';
import 'section_style.dart';

class TermSection {
  final String section;
  final BilingualContent? title;
  final dynamic content; // Can be BilingualContent or BilingualList
  final SectionStyle style;

  TermSection({
    required this.section,
    this.title,
    required this.content,
    required this.style,
  });

  factory TermSection.fromJson(Map<String, dynamic> json) {
    dynamic parsedContent;

    if (json['content'] != null) {
      final contentData = json['content'];

      // Check if content is a list
      if (contentData['en'] is List || contentData['ar'] is List) {
        parsedContent = BilingualList.fromJson(contentData);
      } else {
        parsedContent = BilingualContent.fromJson(contentData);
      }
    }

    return TermSection(
      section: json['section'],
      title: json['title'] != null
          ? BilingualContent.fromJson(json['title'])
          : null,
      content: parsedContent,
      style: SectionStyle.fromJson(json['style']),
    );
  }
}
