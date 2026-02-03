import 'package:equatable/equatable.dart';
import 'package:flower_app/core/constants/cache_constants.dart';

class MessageResponse extends Equatable {
  final String message;

  const MessageResponse({required this.message});

  factory MessageResponse.fromJson(Map<String, dynamic> json) {
    return MessageResponse(message: json[CacheConstants.errorMessageKey] ?? '');
  }

  @override
  List<Object?> get props => [message];
}
