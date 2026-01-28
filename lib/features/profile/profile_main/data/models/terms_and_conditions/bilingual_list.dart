class BilingualList {
  final List<String> en;
  final List<String> ar;

  BilingualList({required this.en, required this.ar});

  factory BilingualList.fromJson(Map<String, dynamic> json) {
    return BilingualList(
      en: (json['en'] as List<dynamic>).map((e) => e.toString()).toList(),
      ar: (json['ar'] as List<dynamic>).map((e) => e.toString()).toList(),
    );
  }

  List<String> get(String language) {
    return language == 'ar' ? ar : en;
  }
}
