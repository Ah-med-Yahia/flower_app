import 'bilingual_content.dart';

class TextStyleConfig {
  final double fontSize;
  final String fontWeight;
  final String color;
  final BilingualContent textAlign;
  final String backgroundColor;

  TextStyleConfig({
    required this.fontSize,
    required this.fontWeight,
    required this.color,
    required this.textAlign,
    required this.backgroundColor,
  });

  factory TextStyleConfig.fromJson(Map<String, dynamic> json) {
    return TextStyleConfig(
      fontSize: json['fontSize']?.toDouble() ?? 16.0,
      fontWeight: json['fontWeight'] ?? 'normal',
      color: json['color'] ?? '#000000',
      textAlign: BilingualContent.fromJson(json['textAlign']),
      backgroundColor: json['backgroundColor'] ?? '#FFFFFF',
    );
  }
}
