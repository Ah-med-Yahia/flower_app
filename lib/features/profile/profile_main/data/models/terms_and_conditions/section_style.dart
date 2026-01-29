import 'bilingual_content.dart';
import 'text_style_config.dart';

class SectionStyle {
  final TextStyleConfig? title;
  final TextStyleConfig? content;
  final double? fontSize;
  final String? fontWeight;
  final String? color;
  final BilingualContent? textAlign;
  final String? backgroundColor;

  SectionStyle({
    this.title,
    this.content,
    this.fontSize,
    this.fontWeight,
    this.color,
    this.textAlign,
    this.backgroundColor,
  });

  factory SectionStyle.fromJson(Map<String, dynamic> json) {
    return SectionStyle(
      title: json['title'] != null
          ? TextStyleConfig.fromJson(json['title'])
          : null,
      content: json['content'] != null
          ? TextStyleConfig.fromJson(json['content'])
          : null,
      fontSize: json['fontSize']?.toDouble(),
      fontWeight: json['fontWeight'],
      color: json['color'],
      textAlign: json['textAlign'] != null
          ? BilingualContent.fromJson(json['textAlign'])
          : null,
      backgroundColor: json['backgroundColor'],
    );
  }
}
