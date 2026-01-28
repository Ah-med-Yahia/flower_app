import 'package:equatable/equatable.dart';

class MessageResponse extends Equatable {
  final String message;

  const MessageResponse({required this.message});

  factory MessageResponse.fromJson(Map<String, dynamic> json) {
    return MessageResponse(
      message: json['message'] ?? '',
    );
  }

  @override
  List<Object?> get props => [message];
}
