class BilingualContent {
  final String en;
  final String ar;

  BilingualContent({required this.en, required this.ar});

  factory BilingualContent.fromJson(Map<String, dynamic> json) {
    return BilingualContent(en: json['en'] ?? '', ar: json['ar'] ?? '');
  }

  String get(String language) {
    return language == 'ar' ? ar : en;
  }
}
