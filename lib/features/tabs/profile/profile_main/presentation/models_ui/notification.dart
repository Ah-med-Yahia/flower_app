class AppNotification {
  final String id;
  final String? title;
  final String? body;
  final bool isSeen;
  final String time;

  AppNotification({
    required this.id,
    this.title,
    this.body,
    this.isSeen = false,
    required this.time,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'body': body,
        'isSeen': isSeen,
        'time': time,
      };

  factory AppNotification.fromJson(Map<String, dynamic> json) {
    return AppNotification(
      id: json['id'],
      title: json['title'],
      body: json['body'],
      isSeen: json['isSeen'] ?? false,
      time: json['time'],
    );
  }

  AppNotification copyWith({bool? isSeen}) {
    return AppNotification(
      id: id,
      title: title,
      body: body,
      isSeen: isSeen ?? this.isSeen,
      time: time,
    );
  }
}