class ErrorModel {
  final String message;
  final int? code;

  ErrorModel({required this.message, this.code});

  factory ErrorModel.fromResponse({
    required Map<String, dynamic> json,
    required int? statusCode,
  }) {
    return ErrorModel(
      message: json['error'] ?? 'Unknown error',
      code: statusCode,
    );
  }
}
